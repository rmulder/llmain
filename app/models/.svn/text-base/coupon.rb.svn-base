class Coupon < ActiveRecord::Base

  before_validation :generate_coupon_unique_number
#:user_purchase_id, 
  validates_presence_of :user_id, :message_id, :coupon_unique_number, :business_id
  validates_presence_of :first_name, :last_name, :email_address, :if => :gift?
  validates_absence_of :first_name, :last_name, :email_address, :gift_text, :unless => :gift?
  validates_uniqueness_of :coupon_unique_number

  belongs_to :user_purchase
  belongs_to :social_coupon, :foreign_key  => :message_id
  belongs_to :user

  private

  def gift?
    gift_flag.to_s == '1'
  end

  # generate a unique, readable code: generate a code in a look checking that it is valid in the DB
  def generate_coupon_unique_number
    until Coupon.find_by_coupon_unique_number(self.coupon_unique_number = generate_code).nil?
      # noop
    end
  end

  def generate_code(size = 10)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z}
    (0...size).map { charset.to_a[rand(charset.size)] }.join
  end


end
