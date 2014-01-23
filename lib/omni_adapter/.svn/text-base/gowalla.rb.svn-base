class OmniAdapter

  # Gowalla-specific oauth adapter
  class Gowalla < BaseAdapter
    def client
      params = {
        :parse_json => true
      }

      @client ||= OAuth2::Client.new(AppConf.gw_consumer_key, AppConf.gw_consumer_secret, params)
    rescue => e
      handle_rescue(e)
    end

    def token
      @token ||= OAuth2::AccessToken.new(client, access_token, {:mode => :query, :param_name => 'oauth_token', :mode => :header, :header_format => 'Token token="%s"'})
    end # token

    def access_token_secret
      @secret ||= '' # not used by oauth2
    rescue => e
      handle_rescue(e)
    end # access_token_secret

    def user
      res = token.get('https://api.gowalla.com/users/' + sn_user_id.to_s + '.json', opts)
      res = ActiveSupport::JSON.decode(res.response.body)
      {
        'external_reference_id' => res['url'].split('/').last,
        'first_name' => res['first_name'],
        'last_name' => res['last_name'],
        'city' => res['hometown'].to_s.split(',').first.to_s.strip,
        'state' => State::NAMES[res['hometown'].to_s.split(',').last.to_s.strip],
        'photo' => res['image_url'],
        'gender' => ''
      }
    rescue => e
      handle_rescue(e)
    end # user

    def friends
      res = token.get('https://api.gowalla.com/users/' + sn_user_id.to_s + '/friends.json', opts)
      res = ActiveSupport::JSON.decode(res.response.body)
      out = {}
      if res['users'].present?
        res = res['users']
        res.each{|friend|
          out[friend['url'][7..-1].to_i] = {
            'id' => friend['url'][7..-1].to_i,
            'name' => "#{friend['first_name']} #{friend['last_name']}".strip,
            'first_name' => friend['first_name'],
            'last_name' => friend['last_name'],
            'user_name' => nil,
            'location' => friend['hometown'],
            'email' => nil,
            'photo' => friend['image_url'],
            'foursquare_id' => nil,
            'gowalla_id' => friend['url'][7..-1].to_i,
            'facebook_id' => nil,
            'twitter_id' => nil
          }
        }
      end

      out
    rescue => e
      handle_rescue(e)
    end # friends

    def checkins(params)
      params = params.only_valid_keys ['since']
      res = token.get('https://api.gowalla.com/users/' + sn_user_id.to_s + '/events.json', opts(params))
      res = ActiveSupport::JSON.decode(res.response.body)['activity']

      out = []
      if res.present?
        res.each{|checkin|
          out << {
            'external_reference_id' => checkin['spot']['url'].split('/').last,
            'external_activity_id' => checkin['url'].split('/').last,
            'activity_datetime' => Time.parse(checkin['created_at']).utc.to_i,
            'activity_timezone' => Time.parse(checkin['created_at']).zone,
            'activity_comment' => checkin['message'],
            'business_name' => checkin['spot']['name'],
            'business_city' => checkin['spot']['city_state'].to_s.split(',').first.to_s.strip,
            'business_state' => checkin['spot']['city_state'].to_s.split(',').last.to_s.strip,
            'business_zip' => '',
            'business_country' => '', #todo get this
            'business_phone' => '', #todo get this
            'business_address' => '',
            'business_lat' => checkin['spot']['lat'],
            'business_lng' => checkin['spot']['lng'],
            'business_type' => ''
          }
        }
      end

      out
    rescue => e
      handle_rescue(e)
    end # checkins

    def checkins_next_page(params)
      last_checkin = ExternalUserActivity.first(
        :joins => "inner join tbl_data_sources ds on ds.data_source_id = tbl_external_user_activities.data_source_id and data_source_name = '#{provider}'",
        :conditions => {
          :user_id => user_id
        },
        :order => 'external_activity_id desc',
        :select => 'external_activity_id'
      )

      # get the most recent checkin
      external_activity_id = last_checkin.nil? ? 0 : last_checkin.external_activity_id.to_i
      limit = 100
      offset = 0
      new_checkins = []
      pop = false
      # loop through checkins 100 at a time until we run out of checkins or reach the most recent imported checkin
      begin
        # get limit / offset checkins
        page = checkins({:limit => limit, :offset => offset})

        # is this an error hash instead of an array of results?
        if page.is_a? Hash
          return page
        end

        # loop through the page of checkins
        page.each{|checkin|
          # only add the checkin to the list if it's new
          if checkin['external_activity_id'].to_i > external_activity_id
            new_checkins << checkin
          else
            # if it's not new, break out of the loop
            pop = true
            break
          end
        }

        offset += 100
        # repeat unless we've run out of records or we've passed the most recent imported checkin
      end while !pop && page.length == 100

      new_checkins
    rescue => e
      handle_rescue(e)
    end # checkins_next_page

    def handle_rescue(e)
      ActiveRecord::Base.logger.info e.to_yaml
      if e.is_a? OAuth2::Error
        res = ActiveSupport::JSON.decode(e.response.body)
        if res.is_a? Hash
          output_rescue({
            :error_code => e.response.status,
            :title => 'Gowalla error: ' + res['error'].to_s,
            :message => res['detail'],
            :trace => e.backtrace
          })
        else
          output_rescue({
            :error_code => e.response.status,
            :title => 'Gowalla error',
            :message => e.message,
            :trace => e.backtrace
          })
        end
      else
        output_rescue({
          :error_code => 11,
          :title => 'Gowalla error',
          :message => e.message,
          :trace => e.backtrace
        })
      end
    end # handle_rescue

    def opts(params={})
      {
        :raise_errors=>false,
        :headers =>{:Accept => 'application/json','X-Gowalla-API-Key'=> AppConf.gw_consumer_key},
        :params => params
      }
    end # opts

  end # Gowalla

end