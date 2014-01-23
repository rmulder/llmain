describe SocialCoupon do

  before(:each) do
    user = Factory(:user)
    sc   = Factory(:social_coupon)
  end

  it "is valid with valid attributes" do
    sc=SocialCoupon.new(@valid_attributes)
    sc.errors.should be_empty
    sc.save
    sc.errors.should be_empty
    sc.should be_valid
  end

  it "is purchasable when active" do
    purchase_social_coupon(user, sc)
  end

  it "is not purchasable when sold out" do
    sell_out(sc)


  end

  it "is not purchasable when already sold to user" do

  end

  it "is not purchasable when expired" do

  end

  it "shows the purchase count increase when purchased" do

  end

  def purchase_social_coupon
    
  end

end

### FROM MODEL TO GUIDE TEST REQUIREMENTS
#  set_table_name "smb_promo_messages"
#  set_primary_key :message_id
#
#  set_inheritance_column :message_type
#
#  belongs_to :business, :foreign_key => :businesses_id
#
#  has_many :social_coupons, :foreign_key => :message_id, :primary_key => :message_id
#
#  validates_presence_of :one_min_message, :gift_headline, :description, :retail_value,
#                        :purchase_price, :min_quantity_per_person,
#                        :message_terms, :max_quantity_per_person,
#                        :deal_start_timestamp, :deal_end_timestamp, :business, :city
#
#  validates_numericality_of :retail_value, :purchase_price, :min_quantity_per_person,
#                            :max_quantity_per_person
#
#  validates_numericality_of :max_quantity_provided, :if => :max_quantity_provided
#
#  validates_length_of :one_min_message, :maximum => 255, :allow_blank => false
#  validates_length_of :gift_headline, :maximum => 255, :allow_blank => false
#  validates_length_of :message_terms, :maximum => 2048, :allow_blank => false
#  validates_length_of :description, :maximum => 16777215, :allow_blank => false
#
#  validates_presence_of :start_timestamp, :end_timestamp, :description#, :message_title
#
#  has_many :images, :as => :reference, :foreign_key  => :message_id, :dependent => :destroy
#
#  #todo add validations for reasonableness on data (e.g. min<max, end>start, etc)