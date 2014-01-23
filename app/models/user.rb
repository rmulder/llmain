class User < ActiveRecord::Base
  belongs_to :location
  has_many :authentications
  has_one :email_authentication, :class_name => "Authentication", :conditions => "sn_id = 0"
  has_many :user_purchases
  has_many :lists, :as => :owner
  has_one :default_list, :as => :owner
  has_many :custom_lists, :as => :owner
  has_many :likes, :as => :owner
  has_many :trys, :as => :owner
  has_many :friend_lists, :foreign_key=>:from_user_id
  has_many :friends, :through => :friend_lists
  has_many :social_network_profiles
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  # :validatable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :password_confirmation, :remember_me, :first_name, :last_name, :email, :password
  # todo shorthand list construction methods


  #validates_presence_of :default_list, :last_name
  #validates_presence_of :default_list

  default_value_for :first_name, ''
  default_value_for :last_name, ''
  default_value_for :password, ''
  default_value_for :user_level, 'user'
  default_value_for :profile_status, 'active'


  def email
    email_authentication.nil? ? '' : email_authentication.email
  end

  def email=email
    self.save!
    if self.email_authentication.nil?
      logger.info "In email method:#{self.to_s}"
      x = Authentication.new :email => email, :sn_id => 0, :sn_user_id => self.id, :user_id => self.id
      self.email_authentication = x
    else
      self.email_authentication.email = email
    end
  end

  def apply_omniauth(omniauth)
    o = OmniAdapter.new omniauth unless omniauth.blank?
    logger.info "OmniAdapter:#{o.to_yaml}"

    self.first_name = o.first_name.to_s
    self.last_name = o.last_name.to_s
    self.preferred_sn_id = o.sn_id
    self.data_source_id = o.sn_id == 1 ? 5 : 0
    self.profile_photo_path = o.sn_id == 1 ? 'https://graph.facebook.com/' + o.sn_user_id.to_s + '/picture' : ''
    # see the OmniAdapter -- it picks apart all the values to make this part a bit cleaner
    # (this could probably be done in a more elegant way still)
    authentications.build(:sn_id => o.sn_id,
                          :sn_user_id => o.sn_user_id,
                          :email => o.email, 
                          :full_name => o.full_name,
                          :user_name => o.user_name,
                          :authentication_token => o.authentication_token,
                          :access_token => o.access_token,
                          :access_token_secret => o.access_token_secret)
  end
  
  def password_required?
    #(authentications.empty? || !password.blank?) && super
    (authentications.empty? || !password.blank?)
    #legacy_password_md5.blank? && super
    #false
  end

  def friends_who_like_business_id(business_id)
    ListEntry.all(
        :select => 'profile_photo_path, first_name, last_name, to_user_id user_id, comments, list_entries.updated_at rated_on',
        :joins => ["inner join users on users.id = owner_id",
                   "LEFT JOIN comments ON comments.list_entry_id = list_entries.id",
                   "inner join user_relationships on to_user_id = owner_id"],
        :conditions => ["from_user_id = ? and entry_business_id = ? and list_entries.type = 'Like'", self.id, business_id],
        :order => 'list_entries.updated_at desc')
    # friends.business_likes(business_id) # too slow!
  end

  def friends_who_want_to_try_business_id(business_id)
    ListEntry.all(
        :select => 'profile_photo_path, first_name, last_name, to_user_id user_id, comments, list_entries.updated_at rated_on',
        :joins => ["inner join users on users.id = owner_id",
                   "LEFT JOIN comments ON comments.list_entry_id = list_entries.id",
                   "inner join user_relationships on to_user_id = owner_id"],
        :conditions => ["from_user_id = ? and entry_business_id = ? and list_entries.type = 'Try'", self.id, business_id],
        :order => 'list_entries.updated_at desc')
    # friends.business_trys(business_id) # too slow!
  end

  protected
  def email_required?
    false
  end

end
