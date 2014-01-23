class SocialNetworkProfile < ActiveRecord::Base
  set_primary_key :promo_site_id

  devise :database_authenticatable, :confirmable, :lockable, :recoverable,
         :rememberable, :registerable, :trackable, :timeoutable, :validatable,
         :token_authenticatable

  attr_accessible :email, :password, :password_confirmation

  belongs_to :user#, :conditions => ['preferred_sn_id = sn_id']
end
