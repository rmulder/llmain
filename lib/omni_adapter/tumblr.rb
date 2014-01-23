class OmniAdapter
  
  # Tumblr-specific oauth adapter
  class Tumblr < BaseAdapter
    def token
      @token ||=
          OAuth::AccessToken.new(
              OAuth::Consumer.new(AppConf.tb_consumer_key, AppConf.tb_consumer_secret, {:site=>"http://tumblr.com"}),
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
      names = omni_hash['extra']['user_hash']['name'].split(' ')
      {
        'external_reference_id' => omni_hash['uid'],
        'first_name' => names[0],
        'last_name' => names.pop(names.length-1).join(' ').strip,
        'city' => '',
        'state' => '',
        'photo' => omni_hash['extra']['user_hash']['avatar_url'],
        'gender' => ''
      }
    rescue => e
      handle_rescue(e)
    end # user

    def friends
      out = {}
      out
    rescue => e
      handle_rescue(e)
    end # friends

    def handle_rescue(e)
      output_rescue({
        :error_code => 13,
        :title => 'Tumblr error',
        :message => e.message,
        :trace => e.backtrace
      })
    end # handle_rescue

  end # Tumblr
end