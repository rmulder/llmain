class OmniAdapter

  # Facebook-specific oauth adapter
  class Facebook < BaseAdapter
    def server
      'https://graph.facebook.com/'
    end

    def client
      params = {
        :parse_json => true,
        :token_url => '/oauth/access_token'
      }

      @client ||= OAuth2::Client.new(AppConf.fb_app_id, AppConf.fb_app_secret, params)
    rescue => e
      handle_rescue(e)
    end

    def token
      @token ||= OAuth2::AccessToken.new(client, access_token, {:mode => :query, :param_name => 'access_token'})
    end # token

    def access_token_secret
      @secret ||= '' # not used by oauth2
    rescue => e
      handle_rescue(e)
    end # access_token_secret

    def user
      {
        'external_reference_id' => user_data['id'],
        'first_name' => user_data['first_name'],
        'last_name' => user_data['last_name'],
        'city' => '',
        'state' => '',
        'photo' => server + user_data['id'] + '/picture',
        'gender' => user_data['gender']
      }
    rescue => e
      handle_rescue(e)
    end # user

    def user_data
      if @user_data.nil?
        res = token.get(server + 'me')
        @user_data = ActiveSupport::JSON.decode(res.response.body)
      end
      @user_data
    rescue => e
      handle_rescue(e)
    end # user_data

    # copied from strategy
    def user_info
      {
        'nickname' => user_data['username'],
        'email' => (user_data['email'] if user_data['email']),
        'first_name' => user_data['first_name'],
        'last_name' => user_data['last_name'],
        'name' => "#{user_data['first_name']} #{user_data['last_name']}",
        'image' => "http://graph.facebook.com/#{user_data['id']}/picture?type=square",
        'urls' => {
          'Facebook' => user_data['link'],
          'Website' => user_data['website'],
        },
      }
    rescue => e
      handle_rescue(e)
    end # user_info

    def friends
      res = token.get(server + 'me/friends')
      res = ActiveSupport::JSON.decode(res.response.body)['data']

      out = {}

      if res.present?
        res.each{|friend|
          out[friend['id']] = {
            'id' => friend['id'],
            'name' => friend['name'],
            'first_name' => friend['first_name'],
            'last_name' => friend['last_name'],
            'user_name' => nil,
            'location' => nil,
            'email' => nil,
            'photo' => server + friend['id'] + '/picture',
            'foursquare_id' => nil,
            'gowalla_id' => nil,
            'facebook_id' => friend['id'],
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
      res = token.get(server + 'me/checkins', {:params => params})
      res = ActiveSupport::JSON.decode(res.response.body)['data']
      out = []
      res.each{|checkin|
        if checkin['place']['location'].nil?
          checkin['place']['location'] = {}
        end
        out << {
          'external_reference_id' => checkin['place']['id'],
          'external_activity_id' => checkin['id'],
          'activity_datetime' => Time.parse(checkin['created_time']).utc.to_i,
          'activity_timezone' => Time.parse(checkin['created_time']).zone,
          'activity_comment' => checkin['message'],
          'business_name' => checkin['place']['name'],
          'business_city' => checkin['place']['location']['city'],
          'business_state' => checkin['place']['location']['state'],
          'business_zip' => checkin['place']['location']['zip'],
          'business_country' => '', #todo get this
          'business_phone' => '', #todo get this
          'business_address' => '',
          'business_lat' => checkin['place']['location']['latitude'],
          'business_lng' => checkin['place']['location']['longitude'],
          'business_type' => ''
        }
      }

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
        :order => 'activity_datetime desc',
        :select => 'activity_datetime'
      )

      params[:since] = last_checkin.nil? ? 0 : last_checkin.activity_datetime

      checkins(params)
    rescue => e
      handle_rescue(e)
    end # checkins_next_page

    def likes
      res = token.get(server + 'me/likes')
      res = ActiveSupport::JSON.decode(res.response.body)['data']
      out = []
      res.each{|like|
        out << {
          'business_name' => like['name'],
          'business_type' => like['category'],
          'external_reference_id' => like['id'],
          'activity_datetime' => Time.parse(like['created_time']).utc.to_i,
          'activity_timezone' => Time.parse(like['created_time']).zone
        }
      }

      out
    rescue => e
      handle_rescue(e)
    end # likes

    def business(external_business_id)
      res = token.get("#{server}#{external_business_id}")
      res = ActiveSupport::JSON.decode(res.response.body)
      if res['location'].nil?
        res['location'] = {}
      end
      {
        'external_reference_id' => res['id'],
        'business_name' => res['name'],
        'business_city' => res['location']['city'],
        'business_state' => res['location']['state'],
        'business_country' => res['location']['country'],
        'business_phone' => res['phone'],
        'business_zip' => res['location']['zip'],
        'business_address' => res['location']['street'],
        'business_lat' => res['location']['latitude'],
        'business_lng' => res['location']['longitude'],
        'business_type' => res['category']
      }
    rescue => e
      handle_rescue(e)
    end # business

    def handle_rescue(e)
      if e.is_a? OAuth2::Error
        ActiveRecord::Base.logger.info e.to_yaml
        res = ActiveSupport::JSON.decode(e.response.body)['error']
        if res.is_a? Hash
          output_rescue({
            :error_code => e.response.status,
            :title => 'Facebook error: ' + res['type'].to_s,
            :message => res['message'],
            :trace => e.backtrace
          })
        else
          output_rescue({
            :error_code => e.response.status,
            :title => 'Facebook error',
            :message => e.message,
            :trace => e.backtrace
          })
        end
      else
        output_rescue({
          :error_code => 14,
          :title => 'Facebook error',
          :message => e.message,
          :trace => e.backtrace
        })
      end
    end # handle_rescue

  end # Facebook
end