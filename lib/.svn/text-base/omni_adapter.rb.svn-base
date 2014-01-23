class OmniAdapter
  def initialize omni_hash
    @omni_hash = omni_hash
    @first_name = ''
    @last_name = ''
    @friends = nil
    if !omni_hash['user_info'].nil?
      if !omni_hash['user_info']['first_name'].nil? && !omni_hash['user_info']['last_name'].nil?
        @first_name = omni_hash['user_info']['first_name']
        @last_name = omni_hash['user_info']['last_name']
      else
        if !@omni_hash['user_info']['name'].nil?
          @first_name, @last_name = @omni_hash['user_info']['name'].split(' ')
        end
      end
    end

    @omni_hash['token_object'] = token
  end # initialize

  def omni_hash
    @omni_hash
  end # omni_hash

  def full_name
    @omni_hash['user_info']['name'] || ''
  end # full_names

  def first_name
    @first_name
  end # first_name

  def last_name
    @last_name
  end # last_names

  def email
    if !@omni_hash['user_info']['email'].nil?
      @omni_hash['user_info']['email']
    elsif !@omni_hash['extra']['user_hash'].nil?
      if !@omni_hash['extra']['user_hash']['email'].nil?
        @omni_hash['extra']['user_hash']['email']
      else
        ''
      end
    else
      ''
    end
  end # email

  def user_name
    user_name = @omni_hash['user_info']['nickname'] || ''
    if user_name.empty?
      user_name = @omni_hash['screen_name'] unless @omni_hash['screen_name'].nil?
    end
    user_name
  end # user_name

  def provider
    @omni_hash['provider']
  end # provider

  def authentication_token
    @omni_hash['oauth_token'] unless @omni_hash['oauth_token'].nil?
  end # authentication_token

  def access_token
    if !@omni_hash['credentials'].nil? && !@omni_hash['credentials']['token'].nil?
      @omni_hash['credentials']['token']
    elsif !@omni_hash['extra'].nil? && !@omni_hash['extra']['access_token'].nil?
      @omni_hash['extra']['access_token']
    else
      ''
    end
  end # access_token

  def access_token_secret
    if !@omni_hash['extra'].nil? && !@omni_hash['extra']['access_token_secret'].nil?
      # grab the stored secret if we have it
      @secret ||= @omni_hash['extra']['access_token_secret']
    else
      # otherwise grab it from the adapter
      @secret ||= adapter.access_token_secret
    end
  end # access_token_secret

  def sn_id
    @omni_hash['sn_id'] || ''
  end # sn_id

  def ds_id
    Authentication.provider_to_ds_id(provider)
  end # ds_id

  def sn_user_id
    @omni_hash['uid'] || ''
  end # sn_user_id

  def user_id
    @omni_hash['user_id'] || ''
  end # user_id

  # return an object to point to the particular social network
  def adapter
    @adapter ||= case provider
      when 'facebook'
        Facebook.new self
      when 'foursquare'
        Foursquare.new self
      when 'twitter'
        Twitter.new self
      when 'gowalla'
        Gowalla.new self
      when 'tumblr'
        Tumblr.new self
      end
  end # adapter

  def client
    @client ||= adapter.client
  end # client

  def token
    @token ||= adapter.token
  end # token

  def authentication_data
    @authentication_data ||= ActiveSupport::JSON.decode(@omni_hash['extra']['authentication_data'].to_s) || {}
  end # authentication_data

  def friends
    @friends ||= adapter.friends || {}
  end # friends

  def friends_cached
    @friends ||= authentication_data['friends'] || {}
  end # friends

  def user
    @user ||= adapter.user || {}
  end # user

  def user_info
    @user_info ||= adapter.user_info || {}
  end # user_info

  def business(external_business_id)
    adapter.business(external_business_id)
  end # business

  def checkins(params)
    # route to the correct get checkins function
    next_page = params[:next_page].present? ? params[:next_page].to_i : 0

    if next_page != 0
      adapter.checkins_next_page(params)
    else
      adapter.checkins(params)
    end

  end # checkins

  def likes_from_checkins(threshold=2, override=true, limit=250, offset=0)
    checkin_array = {}
    checkins({:limit => limit, :offset => offset}).each{|checkin|
      if checkin_array[checkin['external_reference_id']].nil?
        checkin_array[checkin['external_reference_id']] = checkin.merge({'checkin_count' => 1})
      else
        checkin_array[checkin['external_reference_id']]['checkin_count'] += 1
      end
    }

    checkin_array_out = []
    checkin_array.each_value{|checkin|
      if checkin['checkin_count'].to_i >= threshold.to_i
        checkin_array_out << checkin
      end
    }

    checkin_array_out
  end # likes_from_checkins

  def likes(params)
    # route to the correct get checkins function
    next_page = params[:next_page].present? ? params[:next_page].to_i : 0

    all_likes = adapter.likes

    # if it's a hash, it is an error hash
    if all_likes.is_a? Hash
      return all_likes
    end

    if next_page != 0
      # get the existing external likes for this user and provider
      current_likes = ExternalLike.all(:conditions => {:data_source_id => ds_id, :external_user_id => sn_user_id}, :select => 'external_reference_id')
      if !current_likes.nil?
        current_likes.map!{|like| like['external_reference_id'].to_s}.uniq
        # filter out existing likes
        new_likes = []
        all_likes.each{|like|
          if !current_likes.include? like['external_reference_id'].to_s
            new_likes << like.merge({'business_new' => 0})
          end
        }
      else
        new_likes = all_likes
      end

      # get all the new external business IDs
      new_businesses = new_likes.map{|like| like['external_reference_id']}.uniq.join("','")

      # which external business IDs are already in the DB?
      existing_businesses = ExternalBusiness.all(:conditions => ["external_reference_id in ('#{new_businesses}') and data_source_id = '#{ds_id}'"])
      if existing_businesses.nil?
        existing_businesses = []
      end

      existing_businesses.map!{|business| business['external_reference_id']}.uniq

      all_likes = new_likes.map{|like|
        # add business data if it's really new
        if like['external_reference_id'].present? && !existing_businesses.include?(like['external_reference_id'])
          like = like.merge({'business_new' => 1}).merge(business(like['external_reference_id']))
        end

        like
      }
    end

    all_likes

  end # likes

  def friends_md5
    Digest::MD5.hexdigest(friends.to_json)
  end # friends_md5

end # OmniAdapter

require 'omni_adapter/base_adapter'