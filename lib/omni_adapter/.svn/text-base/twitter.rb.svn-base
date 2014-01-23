class OmniAdapter
  
  # Twitter-specific oauth adapter
  class Twitter < BaseAdapter
    def token
      @token ||=
          OAuth::AccessToken.new(
              OAuth::Consumer.new(AppConf.tw_consumer_key, AppConf.tw_consumer_secret, {:site=>"http://twitter.com"}),
              access_token, access_token_secret
          )
    rescue => e
      handle_rescue(e)
    end # token

    def access_token_secret
      @secret ||= omni_hash['credentials']['secret']
    rescue => e
      handle_rescue(e)
    end # access_token_secret

    def user
      res = token.get('http://api.twitter.com/1/users/show/' + sn_user_id.to_s + '.json')
      res = ActiveSupport::JSON.decode(res.response.body)
      names = res['name'].split(' ')
      {
        'external_reference_id' => res['id_str'],
        'first_name' => names[0],
        'last_name' => names.pop(names.length-1).join(' ').strip,
        'city' => '',
        'state' => '',
        'photo' => res['profile_image_url'],
        'gender' => ''
      }
    rescue => e
      handle_rescue(e)
    end # user

    def friends
      res = token.get('http://api.twitter.com/1/statuses/friends/' + sn_user_id.to_s + '.json')
      res = ActiveSupport::JSON.decode(res.body)
      out = {}
      if res.present?
        res.each{|friend|
          names = friend['name'].split(' ')
          out[friend['id']] = {
            'id' => friend['id'],
            'name' => friend['name'],
            'first_name' => names[0],
            'last_name' => names.pop(names.length-1).join(' ').strip,
            'user_name' => friend['screen_name'],
            'location' => friend['location'],
            'email' => nil,
            'photo' => friend['profile_image_url'],
            'foursquare_id' => nil,
            'gowalla_id' => nil,
            'facebook_id' => nil,
            'twitter_id' => friend['id']
          }
        }
      end # if

      out
    rescue => e
      handle_rescue(e)
    end # friends

    def handle_rescue(e)
      output_rescue({
        :error_code => 13,
        :title => 'Twitter error',
        :message => e.message,
        :trace => e.backtrace
      })
    end # handle_rescue

  end # Twitter
end