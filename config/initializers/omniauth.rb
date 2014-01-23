require 'omni_adapter'
require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, AppConf.tw_consumer_key, AppConf.tw_consumer_secret
  provider :facebook, AppConf.fb_app_id, AppConf.fb_app_secret
  provider :foursquare, AppConf.fs_consumer_key, AppConf.fs_consumer_secret
  provider :linked_in, AppConf.li_consumer_key, AppConf.li_consumer_secret
  provider :gowalla, AppConf.gw_consumer_key, AppConf.gw_consumer_secret
  provider :google, AppConf.gg_consumer_key, AppConf.gg_consumer_secret
  provider :open_id, OpenID::Store::Filesystem.new(AppConf.open_id_fs_dir)
  provider :tumblr, AppConf.tb_consumer_key, AppConf.tb_consumer_secret
#  provider :open_id, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end

# for acceptance testing -- before and after callbacks are pretty much all we can do,
# i.e.. check for <a href="/auth/:provider" , gems internal tests handle redirects
# see http://blog.plataformatec.com.br/2010/12/acceptance-tests-for-omniauth/

#module OmniAuth
#  mattr_accessor :facebook_strategy
#end
#
#Rails.application.config.middleware.use OmniAuth::Strategies::Facebook, "APP_ID", "APP_SECRET" do |strategy|
#  OmniAuth.facebook_strategy = strategy
#end

## Below code overrides the Facebook scope such that we can pass in the scope as a dynamic variable
# no scope uses the default 'email,offline_access'
# ?scope= uses basic
# ?scope=email uses basic & email
# ?scope=offline_access uses basic & offline_access
# ?scope=email,offline_access uses basic, email & offline_access
module OmniAuth
  module Strategies

    class Facebook < OAuth2

      def request_phase
        if request['scope']
          options[:scope] = request['scope']
        else
          options[:scope] = 'email,user_about_me,friends_about_me,user_hometown,friends_hometown,user_location,friends_location,user_website,friends_website,user_checkins,friends_checkins,user_likes,friends_likes,offline_access,read_stream,read_friendlists,publish_stream'
        end
        if request['display']
          options[:display] = request['display']
        end
        super
      end

    end # Facebook

    class Twitter < OAuth

      def user_info
        user_hash = self.user_hash

        {
          'nickname' => user_hash['screen_name'],
          'name' => user_hash['name'] || user_hash['screen_name'],
          'location' => user_hash['location'],
          'image' => user_hash['profile_image_url'],
          'description' => user_hash['description'],
          'urls' => {
            'Website' => user_hash['url'],
            'Twitter' => 'http://twitter.com/' + user_hash['screen_name']
          }
        }
      end

      def initialize(app, consumer_key=nil, consumer_secret=nil, options={}, &block)
        client_options = {
          :site => 'https://api.twitter.com'
        }
        options[:authorize_params] = {:force_login => 'true'} if options.delete(:force_login) == true
        client_options[:authorize_path] = '/oauth/authorize' unless options[:sign_in] == false
        super(app, options[:name] || :twitter, consumer_key, consumer_secret, client_options, options, &block)
      end
    end # Twitter

    class Foursquare < OAuth2

      def user_info
        {
          'nickname' => user_data['response']['user']['contact']['twitter'],
          'twitter' => user_data['response']['user']['contact']['twitter'],
          'facebook' => user_data['response']['user']['contact']['facebook'],
          'first_name' => user_data['response']['user']['firstName'],
          'last_name' => user_data['response']['user']['lastName'],
          'email' => user_data['response']['user']['contact']['email'],
          'name' => "#{user_data['response']['user']['firstName']} #{user_data['response']['user']['lastName']}".strip,
          'location' => user_data['response']['user']['homeCity'],
          'image' => user_data['response']['user']['photo'],
          'description' => user_data['response']['user']['description'],
          'phone' => user_data['response']['user']['contact']['phone'],
          'urls' => {}
        }
      end
    end # Foursquare

    class Gowalla < OAuth2

      def request_phase
        if request['scope']
          options[:scope] = request['scope']
        else
          options[:scope] = 'read-write'
        end
        super
      end

      # monkey patch from here https://github.com/intridea/omniauth/issues/485, https://github.com/intridea/omniauth/pull/506/files
      # may become obsolete soon (currently 10/19/2011 omniauth 0.3)
      def build_access_token
        token=super
        ##remove expires_at from token, invalid format
        token=::OAuth2::AccessToken.new(token.client,token.token,{:expires_in=>token.expires_in,:refresh_token=>token.refresh_token}.merge(token.params))
        ## if token is expired refresh and again remove expires_at
        if token.expired?
          token=token.refresh!
          token=::OAuth2::AccessToken.new(token.client,token.token,{:expires_in=>token.expires_in,:refresh_token=>token.refresh_token}.merge(token.params))
        end
        token
      end # build_access_token

       def user_data
        if(@data.nil?)
          opts={
            :raise_errors=>false,
            :headers =>{:Accept => 'application/json','X-Gowalla-API-Key'=> self.client_id},
            :params=>{:oauth_token=>@access_token.token}
            }
          response=@access_token.get('http://api.gowalla.com/users/me',opts)

          @data = MultiJson.decode(response.body)
        end

        @data
       end # user_data

      # end monkey patch

   end # Gowalla

  end # Strategies
end # OmniAuth
