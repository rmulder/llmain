class PromoMessage < ActiveRecord::Base

  set_table_name "smb_promo_messages"
  set_primary_key :message_id

  set_inheritance_column "message_type"

  belongs_to :business
  belongs_to :city

  has_many :social_coupons, :foreign_key => :message_id, :primary_key => :message_id
  has_one :transaction_term

  validates_presence_of :one_min_message, :gift_headline, :description, :retail_value,
                        :purchase_price, :min_quantity_per_person,
                        :message_terms, :max_quantity_per_person,
                        :deal_start_timestamp, :deal_end_timestamp, :business, :city

  validates_numericality_of :retail_value, :purchase_price, :min_quantity_per_person,
                            :max_quantity_per_person

  validates_numericality_of :max_quantity_provided, :if => :max_quantity_provided

  validates_length_of :one_min_message, :maximum => 255, :allow_blank => false
  validates_length_of :gift_headline, :maximum => 255, :allow_blank => false
  validates_length_of :message_terms, :maximum => 2048, :allow_blank => false
  validates_length_of :description, :maximum => 16777215, :allow_blank => false

  validates_presence_of :start_timestamp, :end_timestamp, :description#, :message_title

  has_many :images, :as => :reference, :foreign_key  => :message_id, :dependent => :destroy

  #todo add validations for reasonableness on data (e.g. min<max, end>start, etc)

  after_create :reflect_create
  after_update :reflect_update

  def reflect_create
    update_activity_model(true)
  end

  def reflect_update
    if start_timestamp_changed? || end_timestamp_changed?
      update_activity_model(false)
    end
  end

  def update_activity_model(is_new)
    if is_new
      act_data = {
        'entry_id' => business_id,
        'message_id' => message_id,
        'city_id' => business.city_id,
        'start_timestamp' => start_timestamp,
        'end_timestamp' => end_timestamp,
        'owner_id' => nil
      }
      Activity.addActivity(message_type, act_data);
    else
			act_data = {
        'subject_id' => business_id,
        'activity_type' => message_type,
        'activity_owner_type' => Activity.owner_type_business.downcase,
        'activity_group' => Activity.list_entry_type_deal.downcase,
        'source_activity_id' => message_id
      }
      Activity.updateActivity(act_data, business.city_id, start_timestamp, end_timestamp)
    end
  end

  def message_type_message
		'message'
  end
  def message_type_offer
		'offer'
  end
  def message_type_third_party
		'third_party_offer'
  end
  def message_type_social_coupon
		'SocialCoupon'
  end

end
