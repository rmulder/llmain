# The BaseAdapter helps abstract the individual social network connectors
class OmniAdapter
  class BaseAdapter
    def initialize(parent)
      @parent = parent
    end # initialize

    def client
    end # client

    def token
      @token ||= OAuth2::AccessToken.new(client, access_token)
    end # token

    def access_token
      @parent.access_token
    end # access_token

    def omni_hash
      @parent.omni_hash
    end # omni_hash

    def sn_user_id
      @parent.sn_user_id
    end # sn_user_id

    def user_id
      @parent.user_id
    end # user_id

    def user_name
      @parent.user_name
    end # user_name

    def provider
      @parent.provider
    end # provider

    def friends
      []
    end # friends

    def user
      {}
    end # user

    def business(external_business_id)
      {}
    end # business

    def checkins(params)
      []
    end # checkins

    def checkins_next_page(params)
      []
    end # checkins_next_page

    def likes
      []
    end # likes

    def handle_rescue(e)
      output_rescue({
        :error_code => 10,
        :title => provider + ' error',
        :message => e.message,
        :trace => e.backtrace
      })
    end # handle_rescue

    def output_rescue(err_data)
      # todo - email this error to someone?

      if ::Rails.env == 'production'
        err_data[:trace] = nil
      end

      err_data
    end # output_rescue

  end
end

require 'omni_adapter/facebook'
require 'omni_adapter/foursquare'
require 'omni_adapter/twitter'
require 'omni_adapter/gowalla'
require 'omni_adapter/tumblr'