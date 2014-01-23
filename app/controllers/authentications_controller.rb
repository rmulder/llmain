class AuthenticationsController < ApplicationController
  require 'net/https'
  require 'open-uri'
  skip_filter :http_basic

  def index
    @authentications = current_user.authentications if current_user
    render :layout => false
  end # index

  def primary
    @authentications = current_user.authentications if current_user
    # render :text => AppConf.base_url
  end # primary

  def create
    if params[:uid].present? && params[:provider].present? && params[:token].present?
      omniauth = {
        'user_info' => {
          'name' => '', 'urls' => {}, 'nickname' => '', 'last_name' => '', 'image' => '', 'first_name' => '', 'email' => ''
        },
        'uid' => params[:uid],
        'credentials' => {
            'token' => params[:token],
            'refresh_token' => 'true'
        },
        'extra' => {
          'user_hash' => {
              'name' => '', 'work' => {}, 'timezone' => '', 'gender' => '', 'id' => params[:uid], 'last_name' => '', 'first_name' => '', 'email' => '', 'updated_time' => '', 'verified' => '', 'locale' => '', 'link' => ''
          }
        },
        'provider' => params[:provider],
        'alt_login' => true
      }
    else
      omniauth = request.env["omniauth.auth"]
    end

    logger.debug "provider: " + omniauth['provider']
    logger.debug "Raw SocialNetwork data:" + omniauth.to_yaml

    # Question: To debug or rewrite (refactor)
    auth_logger = Logger.new(File.join(RAILS_ROOT, 'log', 'authentications.log'))

    # Converts string based provider to integer based sn_id
    omniauth['sn_id'] = Authentication.provider_to_sn_id(omniauth['provider'])
    # Looks up in active record sn_id (provider) & token received from OmniAuth gem

    auth_logger.info [omniauth['sn_id'], omniauth['uid']]
    o = OmniAdapter.new omniauth

    # Check social_network_profiles SQL table
    authentication = Authentication.find_by_sn_id_and_sn_user_id(
      omniauth['sn_id'],
      omniauth['uid']
    )

    # If the user is already logged in (social_networking_profiles table)
    if authentication

      auth_logger.info 'branch #1'
      #logger.debug "Already signed in:" + omniauth.to_yaml
      auth_logger.info 'session::' + session.to_yaml
      auth_logger.info 'cookies::' + cookies.to_yaml
      auth_logger.info [current_user.class, current_user.inspect]

      ## update relationship to user table
      if authentication.user_id.nil?
        authentication.update_attribute(:user_id, current_user.id) if current_user
      elsif current_user && authentication.user_id != current_user.id
        logger.debug "Current user id:" + current_user.id.to_s
        logger.debug "Authentication user_id:" + authentication.user_id.to_s
        logger.debug "Authentication data:" + omniauth.to_yaml
        logger.debug "OmniAdapter data:" + o.to_yaml
        sn = omniauth['provider'].to_s.titleize
        username = (o.first_name.to_s + " " + o.last_name.to_s).strip
        if omniauth['provider'] == 'twitter'
          username += ', ' + omniauth['user_info']['nickname']
        elsif omniauth['provider'] == 'facebook' || omniauth['provider'] == 'foursquare'
          username += ', ' + o.email
        end
        failure_auth "This " + sn + " user login (#{username}) is already associated with a different LikeList account. Please log out of "  + sn + " or LikeList and try again using a different combination of " + sn + " or LikeList account credentials."
        return
      end
      flash[:notice] = "Signed in successfully."

      # sign_in(:user, authentication.user)
      # sign_in_and_redirect(:user, authentication.user)

    ## (user table)
    elsif current_user
      auth_logger.info 'branch #2'
      logger.debug "Current User:" + omniauth['user_info'].to_yaml
      #logger.debug "Omniauth:" + o.to_yaml
      existing_authentication = current_user.authentications.find_by_sn_id(o.sn_id)
      if existing_authentication.present?
        logger.debug "Current user id:" + current_user.id.to_s
        logger.debug "Authentication user_id:" + existing_authentication.sn_user_id.to_s
        logger.debug "Authentication data:" + omniauth.to_yaml
        logger.debug "OmniAdapter data:" + o.to_yaml
        sn = omniauth['provider'].to_s.titleize
        username = (o.first_name.to_s + " " + o.last_name.to_s).strip
        if omniauth['provider'] == 'twitter'
          username += ', ' + omniauth['user_info']['nickname']
        elsif omniauth['provider'] == 'facebook' || omniauth['provider'] == 'foursquare'
          username += ', ' + o.email
        end

        failure_auth "A different #{sn} user login (#{existing_authentication.sn_user_id.to_s}, #{existing_authentication.full_name}) is already associated with this LikeList account. Cannot associate #{username}"
        return
      end
      new_auth = {
        :sn_id => o.sn_id,
        :sn_user_id => o.sn_user_id,
        :email => o.email,
        :full_name => o.full_name,
        :user_name => o.user_name,
        :authentication_token => o.authentication_token,
        :access_token => o.access_token,
        :access_token_secret => o.access_token_secret}
      current_user.authentications.create!(new_auth)
      if current_user.first_name.empty? || current_user.last_name.empty?
        current_user.update_attributes(
          :first_name => o.first_name,
          :last_name => o.last_name
        )
      end
      flash[:notice] = "Authentication successful."

      # redirect_to authentications_url

    else
      auth_logger.info 'branch #3'

      if omniauth['alt_login'].present?
        # if we logged in via api instead of standard auth, get complete user_info
        omniauth['user_info'] = o.user_info

        # refresh OmniAdapter
        o = OmniAdapter.new omniauth
      end

      merge_user = false
      if omniauth['user_info']['email'].present?
        # do we have an existing LikeList account with the same email address?
        existing_auth = Authentication.find_by_sn_id_and_email(0, o.email)

        if !existing_auth.nil?
          auth_logger.info 'existing user'
          # we do, does that account already have a record for this social network?
          existing_this_auth = Authentication.find_by_sn_id_and_user_id(o.sn_id, existing_auth.user_id)

          if existing_this_auth.nil?
            auth_logger.info 'no existing auth - creating one'
            # that user exists and they have no record for this social network

            # create a new authentication for this social network for this user
            new_auth = {
              :sn_id => o.sn_id,
              :sn_user_id => o.sn_user_id,
              :email => o.email,
              :full_name => o.full_name,
              :user_name => o.user_name,
              :authentication_token => o.authentication_token,
              :access_token => o.access_token,
              :access_token_secret => o.access_token_secret}
            existing_auth.user.authentications.create!(new_auth)
            merge_user = true
          end # if
        end # if
      end # if

      if !merge_user
        auth_logger.info 'no existing user - creating one'
        # we didn't find any existing users - make a new one
        user = User.new
        user.apply_omniauth(omniauth)

        if user.save
          flash[:notice] = "Signed in successfully."
          flash[:notice] = "Signed in successfully."
          # sign_in(:user, authentication.user)
          # sign_in_and_redirect(:user, user)
        else
          session[:omniauth] = omniauth.except('extra')
          redirect_to new_user_registration_url
        end
      end # if

    end # if

    authentication = Authentication.find_by_sn_id_and_sn_user_id(
      omniauth['sn_id'],
      omniauth['uid']
    )

    new_friends_md5 = ''
    friends_changed = false
    omniauth['friends'] = {}
    friends = o.friends
    if friends.present?
      if friends[:error_code].to_i == 0
        omniauth['friends'] = friends
      elsif !authentication.authentication_data.nil?
        ActiveRecord::Base.logger.info 'WE GOT AN ERROR SO WE USED OLD DATA: ' + friends[:error_code].to_s
        authentication_data = ActiveSupport::JSON.decode(authentication.authentication_data)
        if authentication_data.kind_of?(Array)
          omniauth['friends'] = ['friends']
        end
      end
      # overridden below for now
      # new_friends_md5 = o.friends_md5
      # friends_changed = authentication[:sn_user_details_md5].to_s != new_friends_md5
    end
    #auth_logger.info 'loaded friends:' + omniauth['friends'].to_json
    #auth_logger.info omniauth.to_yaml

    # for right now always set the friends changed flag to true
    friends_changed = true

    auth_attrs = {
      :authentication_data => ActiveSupport::JSON.encode(omniauth),
      :authentication_token => o.authentication_token,
      :access_token => o.access_token,
      :access_token_secret => o.access_token_secret
    }

    if friends_changed
      auth_logger.info 'updating changed friends flag'
      auth_attrs = auth_attrs.merge({:import_friends_flag => 1, :sn_user_details_md5 => new_friends_md5})
    end

    #logger.debug "Omniauth:" + omniauth.to_yaml
    if authentication.email.blank? && omniauth['extra']['user_hash'].present? &&
      omniauth['extra']['user_hash']['email'] &&
      !authentication.email_confirmed_flag

      auth_attrs = auth_attrs.merge({:email => omniauth['extra']['user_hash']['email']})
      auth_attrs = auth_attrs.merge({:email_confirmed_flag => 1})
    end

    authentication.update_attributes(auth_attrs)

    sign_in(:user, authentication.user) if authentication.user && !current_user
    #auth_logger.info [authentication.user == current_user]
    auth_logger.info authentication.inspect

    ## brought in from FB import (stub user to real)
    ## existing user record (stub flag => false)
    if current_user
      if current_user.stub_flag == true
        current_user.update_attribute(:stub_flag, false)
        current_user.update_attribute(:sign_in_count, 1)
        current_user.update_attribute(:profile_status, 'active')

        # set first_sync flag on existing job_queue record(s) for this ex-stub user
        # get job queue record(s)
        authentications = Authentication.select('id').find_all_by_user_id(current_user.id)
        if authentications.present?
          authentication_ids = authentications.collect{|auth| auth.id}
          job_queue = JobQueue.find(:all, :conditions => ['social_network_profile_id in (?)', authentication_ids])

          if job_queue.present?
            job_queue.each{|job|
              # get deflated params and re-inflate them
              params = ActiveSupport::JSON.decode(gzinflate(job.serialized_parameters))

              # add first_sync flag
              params['first_sync'] = true

              # deflate params and add to job queue record
              job.serialized_parameters = gzdeflate(ActiveSupport::JSON.encode(params))

              # save job queue record
              job.save
            }
          end
        end
      end
    end

	  email = ''
    if omniauth['extra']['user_hash'].present? && omniauth['extra']['user_hash']['email'].present?
    	email = omniauth['extra']['user_hash']['email']
    end
    # Create JSON data
    response = {
      :error_code => 0,
      :session_key => omniauth['credentials']['token'],
      :sn_id => omniauth['sn_id'],
      :uid => omniauth['uid'],
      :email => email,
      :email_confirmed => authentication.email_confirmed_flag
    }

    # Temporary until such time as OmniAuth would handle all login & authentication
    sign_out_all_scopes

    @json_data = response.to_json
    auth_logger.info @json_data

    respond_to do |format|
      format.html { render :layout => false } # create.html.erb
      format.json  { render :json => response }
      format.xml  { render :xml => response }
    end
  end # create

  def failure options = {}
    response = {
      :error_code => 1,
      :title => 'Login failed',
      :message => 'Sorry, we are unable to authenticate you with the selected service at this time. You must allow the requested permissions or you will be unable to authenticate with LikeList using this service. Please try your request again.'
    }.merge(options)

    @error_data = response.to_json
    render :layout => false
  end # failure

  def failure_auth msg = 'No Error Specified'
    response = {
      :error_code => 2,
      :title => 'Authentication failed',
      :message => msg.to_s
    }

    sign_out_all_scopes
    @json_data = response.to_json
    render :layout => false
  end # failure_auth

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end # destroy

  def sign_in_existing
    user = User.find(params[:id])
    sign_in(:user, user) if user
    pass_params = params.only_valid_keys ['scope', 'display']
    redirect_to "/auth/#{params[:provider]}?#{pass_params.to_query}"
  end # sign_in_existing

  # rest method to get social network user
  def user
    o = _set_up_oauth

    if o.is_a? String
      @out = {
        :error_code => 3,
        :title => 'Error',
        :message => o
      }
    else
      @out = o.user
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @out}
      format.json  { render :json => @out}
    end

  end # user

  # rest method to get social network business
  def business
    o = _set_up_oauth

    if o.is_a? String
      @out = {
        :error_code => 4,
        :title => 'Error',
        :message => o
      }
    else
      @out = o.business(params[:business_id])
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @out}
      format.json  { render :json => @out}
    end

  end # business

  # rest method to get social network friends
  def friends
    o = _set_up_oauth

    if o.is_a? String
      @out = {
        :error_code => 5,
        :title => 'Error',
        :message => o
      }
    else
      if params[:refresh].to_i == 1
        @out = o.friends
        @authentication.update_attribute(:authentication_data, ActiveSupport::JSON.encode(o.authentication_data.merge({'friends' => @out})))
      else
        @out = o.friends_cached
      end
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @out}
      format.json  { render :json => @out}
    end

  end

  # rest method to get social network checkins
  def checkins
    o = _set_up_oauth

    if o.is_a? String
      @out = {
        :error_code => 6,
        :title => 'Error',
        :message => o
      }
    else
      @out = o.checkins(params)
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @out}
      format.json  { render :json => @out}
    end
  end

  # rest method to get social network likes
  def likes
    o = _set_up_oauth

    if o.is_a? String
      @out = {
        :error_code => 7,
        :title => 'Error',
        :message => o
      }
    else
      @out = o.likes(params)
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @out}
      format.json  { render :json => @out}
    end
  end # likes

  def full_profile
    o = _set_up_oauth

    if o.is_a? String
      @out = {
        :error_code => 8,
        :title => 'Error',
        :message => o
      }
    else
      @out = {}
      @out[:businesses] = {}
      @out[:user] = o.user

      # fail for user
      if @out[:user][:error_code].present?
        @out = @out[:user]
      else
        # fail for user
        @out[:friends] = o.friends_cached
        if @out[:friends][:error_code].present?
          @out = @out[:friends]
        else
          @out[:likes] = o.likes(params)
          # fail for likes
          if @out[:likes].is_a? Hash
            # if it's a hash, it is an error hash
            @out = @out[:likes]
          else
            # collect businesses from the likes
            if @out[:likes]
              @out[:likes].each {|result|

                # no ID, skip
                if result['external_reference_id'].nil?
                  next
                end

                # already in our list, skip
                if @out[:businesses][result['external_reference_id']].present?
                  next
                end

                # add it to our list
                @out[:businesses][result['external_reference_id']] = {
                  'external_reference_id' => result['external_reference_id'],
                  'business_name' => result['business_name'],
                  'business_lat' => result['business_lat'],
                  'business_lng' => result['business_lng'],
                  'business_address' => result['business_address'],
                  'business_city' => result['business_city'],
                  'business_state' => result['business_state'],
                  'business_zip' => result['business_zip'],
                  'business_type' => result['business_type']
                }
              }

            end

            # collect businesses from the likes
            if @out[:user]['extra'].present? && @out[:user]['extra']['mayor'].present?
              @out[:user]['extra']['mayor'].each {|result|

                # no ID, skip
                if result['id'].nil?
                  next
                end

                # already in our list, skip
                if @out[:businesses][result['id']].present?
                  next
                end

                business_type = ''
                if result['categories'].present?
                  business_type = result['categories'][0]['name']
                end

                # add it to our list
                @out[:businesses][result['id']] = {
                  'external_reference_id' => result['id'],
                  'business_name' => result['name'],
                  'business_lat' => result['location']['lat'],
                  'business_lng' => result['location']['lng'],
                  'business_address' => result['location']['address'],
                  'business_city' => result['location']['city'],
                  'business_state' => result['location']['state'],
                  'business_zip' => '',
                  'business_type' => business_type
                }
              }

            end


            @out[:checkins] = o.checkins(params)
            # fail for checkins
            if @out[:checkins].is_a? Hash
              # if it's a hash, it is an error hash
              @out = @out[:checkins]
            else
              # collect businesses from the checkins
              if @out[:checkins]
                @out[:checkins].each {|result|
                  # no ID, skip
                  if result['external_reference_id'].nil?
                    next
                  end

                  # already in our list, skip
                  if @out[:businesses][result['external_reference_id']].present?
                    next
                  end

                  # add it to our list
                  @out[:businesses][result['external_reference_id']] = {
                    'external_reference_id' => result['external_reference_id'],
                    'business_name' => result['business_name'],
                    'business_lat' => result['business_lat'],
                    'business_lng' => result['business_lng'],
                    'business_address' => result['business_address'],
                    'business_city' => result['business_city'],
                    'business_state' => result['business_state'],
                    'business_zip' => result['business_zip'],
                    'business_type' => result['business_type']
                  }
                }

              end
            end
          end
        end
      end
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @out}
      format.json  { render :json => @out}
    end
  end # full_profile

  # rest method to get social network likes from checkins
  def likes_from_checkins
    o = _set_up_oauth

    if o.is_a? String
      @out = {
        :error_code => 9,
        :title => 'Error',
        :message => o
      }
    else
      threshold = params[:threshold] || 2
      override = params[:override] || 1
      limit = params[:limit] || 250
      offset = params[:offset] || 0

      @out = o.likes_from_checkins(threshold.to_i, override.to_i, limit.to_i, offset.to_i)
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @out}
      format.json  { render :json => @out}
    end

  end # likes_from_checkins

  def _set_up_oauth
    omniauth = {}
    omniauth['user_id'] = params[:id].to_i.to_s
    omniauth['provider'] = params[:provider]
    omniauth['sn_id'] = Authentication.provider_to_sn_id(params[:provider])

    if omniauth['sn_id'].nil?
      return 'Invalid social network'
    end

    # Looks up in active record sn_id (provider) & token received from OmniAuth gem
    # Check social_network_profiles SQL table
    @authentication = Authentication.find_by_sn_id_and_user_id(
      omniauth['sn_id'],
      omniauth['user_id']
    )

    if @authentication.nil?
      return 'No such social network profile'
    end

    omniauth['uid'] = @authentication.sn_user_id
    omniauth['extra'] = @authentication.attributes
    OmniAdapter.new omniauth
  end # _set_up_oauth

  def fix_fs
    params[:provider] = 'foursquare'
    params[:id] = 217

    o = _set_up_oauth

    res = ExternalBusinessFixFsIds.all(
      :conditions => {:new_external_reference_id => nil},
      :limit => 400
    )

    out = []
    res.each{|biz|
      fs_biz = o.business(biz.external_reference_id)
      new_attrs = {
        'new_business_name' => fs_biz['business_name'],
        'new_city' => fs_biz['business_city'],
        'new_business_phone' => fs_biz['business_phone'],
        'new_country' => fs_biz['business_country'],
        'new_latitude' => fs_biz['business_lat'],
        'new_street' => fs_biz['business_address'],
        'new_zip_code' => fs_biz['business_zip'],
        'new_external_reference_id' => fs_biz['external_reference_id'],
        'new_state' => State::NAMES[fs_biz['business_state'].to_s.strip] || fs_biz['business_state'],
        'new_business_type' => fs_biz['business_type'],
        'new_longitude' => fs_biz['business_lng']
      }
      biz.update_attributes(new_attrs)
      out << fs_biz
    }

    render :json => out
  end # fix_fs


end # AuthenticationsController
