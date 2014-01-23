class Authentication < ActiveRecord::Base
  set_table_name "social_network_profiles"

  belongs_to :user
  # attr_accessible :sn_id, :sn_user_id, :provider, :email, :full_name, :authentication_token, :access_token, :access_token_secret, :user_name

  default_value_for :import_from_sn_flag, 1
  default_value_for :email, ''
  default_value_for :full_name, ''
  before_save :set_other_defaults

  def set_other_defaults
    self.email_confirmed_flag = (provider == 'facebook' || provider == 'foursquare') && !email.blank? ? 1 : 0
  end

  def provider
    provider = Authentication.sn_id_to_provider(sn_id)
  end

  def provider=provider_name
    sn_id = Authentication.provider_to_sn_id(provider_name)
  end

  @social_network_providers = {
    'likelist' => 0, 
    'facebook' => 1, 
    'linked_in' => 2,
    'open_id' => 3,
    'yahoo' => 4,
    'google' => 5,
    'gowalla' => 6,
    'twitter' => 7,
    'foursquare' => 8,
    'tumblr' => 9
  }
  @social_network_ids = @social_network_providers.invert

  @data_sources = {
    'likelist' => 0,
    'facebook' => 5,
    'linked_in' => -1,
    'open_id' => -1,
    'yahoo' => -1,
    'google' => -1,
    'gowalla' => 9,
    'twitter' => 8,
    'foursquare' => 6,
    'tumblr' => -1,
  }
  @data_source_ids = @data_sources.invert

  def self.provider_to_sn_id(provider)
    @social_network_providers[provider] || 0
  end

  def self.sn_id_to_provider(sn_id)
    @social_network_ids[sn_id] || 'likelist'
  end

  def self.provider_to_ds_id(provider)
    @data_sources[provider] || 0
  end

  def self.ds_id_to_provider(ds_id)
    @data_source_ids[ds_id] || 'likelist'
  end

  def provider_name
    if provider == 'open_id'
      "OpenID"
    else
      provider.titleize
    end
  end

  def uid
    sn_user_id
  end
end
