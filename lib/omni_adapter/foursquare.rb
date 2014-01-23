class OmniAdapter

  # Foursquare-specific oauth adapter
  class Foursquare < BaseAdapter
    def client
      params = {
        :parse_json => true,
        :token_url => '/oauth/access_token'
      }

      @client ||= OAuth2::Client.new(AppConf.fs_consumer_key, AppConf.fs_consumer_secret, params)
    rescue => e
      handle_rescue(e)
    end

    def token
      @token ||= OAuth2::AccessToken.new(client, access_token, {:mode => :query, :param_name => 'oauth_token'})
    end # token

    def access_token_secret
      @secret ||= '' # not used by oauth2
    rescue => e
      handle_rescue(e)
    end # access_token_secret

    def user
      res = token.get('https://api.foursquare.com/v2/users/self')
      res = ActiveSupport::JSON.decode(res.response.body)['response']['user']
      {
        'external_reference_id' => res['id'],
        'first_name' => res['firstName'],
        'last_name' => res['lastName'],
        'city' => res['homeCity'].split(',').first.strip,
        'state' => res['homeCity'].split(',').last.strip,
        'photo' => res['photo'],
        'gender' => res['gender'],
        'extra' => {'mayor' => res['mayorships']['items']}
      }
    rescue => e
      handle_rescue(e)
    end # user

    def friends
      res = token.get('https://api.foursquare.com/v2/users/self/friends')
      res = ActiveSupport::JSON.decode(res.response.body)['response']['friends']['items']
      out = {}
      if res.present?
        # break up the list of friends into chunks of five
        # since the "multi" endpoint only accepts five requests at a time
        res.in_groups_of(5) {|chunk|
          query = []
          chunk.each{|friend|
            if friend.present?
              query << '/users/'+friend['id']
            end
          }
          query = query.join(',')
          res = token.get('https://api.foursquare.com/v2/multi?requests=' + query)
          res = ActiveSupport::JSON.decode(res.response.body)['response']

          if res['responses'].present?
            res['responses'].each{|friend|
              friend = friend['response']['user']
              out[friend['id']] = {
                'id' => friend['id'],
                'name' => "#{friend['firstName']} #{friend['lastName']}".strip,
                'first_name' => friend['firstName'],
                'last_name' => friend['lastName'],
                'user_name' => nil,
                'location' => friend['homeCity'],
                'email' => friend['contact']['email'],
                'photo' => friend['photo'],
                'foursquare_id' => friend['id'],
                'gowalla_id' => nil,
                'facebook_id' => friend['contact']['facebook'],
                'twitter_id' => friend['contact']['twitter']
              }
            }
          end
        }

      end

      out
    rescue => e
      handle_rescue(e)
    end # friends

    def checkins(params)
      params = params.only_valid_keys ['limit', 'params', 'afterTimestamp', 'beforeTimestamp']
      res = token.get("https://api.foursquare.com/v2/users/self/checkins", {:params => params})
      res = ActiveSupport::JSON.decode(res.response.body)['response']['checkins']['items']
      out = []
      res.each{|checkin|
        out << {
          'external_reference_id' => checkin['venue']['id'],
          'external_activity_id' => checkin['id'],
          'activity_datetime' => checkin['createdAt'],
          'activity_timezone' => checkin['timeZone'],
          'activity_comment' => checkin['comments']['items'].map{|comment| comment}.join(' '),
          'business_name' => checkin['venue']['name'],
          'business_city' => checkin['venue']['location']['city'],
          'business_state' => checkin['venue']['location']['state'],
          'business_country' => checkin['venue']['location']['country'],
          'business_phone' => checkin['venue']['contact']['phone'],
          'business_zip' => '',
          'business_address' => checkin['venue']['location']['address'],
          'business_lat' => checkin['venue']['location']['lat'],
          'business_lng' => checkin['venue']['location']['lng'],
          'business_type' => checkin['venue']['categories'][0].nil? ? '' : checkin['venue']['categories'][0]['pluralName']
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

      params[:afterTimestamp] = last_checkin.present? ? last_checkin.activity_datetime.to_i + 1 : 0

      checkins(params)
    rescue => e
      handle_rescue(e)
    end # checkins_next_page

    def business(external_business_id)
      res = token.get("https://api.foursquare.com/v2/venues/#{external_business_id}")
      res = ActiveSupport::JSON.decode(res.response.body)['response']['venue']
      {
        'external_reference_id' => res['id'],
        'business_name' => res['name'],
        'business_city' => res['location']['city'],
        'business_state' => res['location']['state'],
        'business_country' => res['location']['country'],
        'business_phone' => res['contact']['phone'],
        'business_zip' => res['location']['postalCode'],
        'business_address' => res['location']['address'],
        'business_lat' => res['location']['lat'],
        'business_lng' => res['location']['lng'],
        'business_type' => res['categories'][0].nil? ? '' : res['categories'][0]['pluralName']
      }
    rescue => e
      handle_rescue(e)
    end # business

    def handle_rescue(e)
      if e.is_a? OAuth2::Error
        ActiveRecord::Base.logger.info e.to_yaml
        res = ActiveSupport::JSON.decode(e.response.body)
        if res.is_a? Hash
          output_rescue({
            :error_code => e.response.status,
            :title => 'Foursquare error: ' + res['errorType'].to_s,
            :message => res['errorDetail'],
            :trace => e.backtrace
          })
        else
          output_rescue({
            :error_code => e.response.status,
            :title => 'Foursquare error',
            :message => e.message,
            :trace => e.backtrace
          })
        end
      else
        output_rescue({
          :error_code => 12,
          :title => 'Foursquare error',
          :message => e.message,
          :trace => e.backtrace
        })
      end
    end # handle_rescue

  end # Foursquare
end