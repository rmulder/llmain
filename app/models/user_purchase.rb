class UserPurchase < ActiveRecord::Base
  belongs_to :user
  has_many :coupons
  has_many :payment_transactions

  accepts_nested_attributes_for :coupons

  before_validation :massage_data
  after_update :update_social_coupon

  attr_accessor :message_id, :qty, :social_coupon

  validates_presence_of :user

  validates_with UserPurchaseValidator

  def massage_data
    if self.id.nil?
      # check if there is already a pending purchase
      #todo - should this go somewhere else?
      other_user_purchase = UserPurchase.first(:conditions => {:user_id => self.user_id, :purchase_status => 'pending'})
      if !other_user_purchase.blank?
        # if yes, mark it failed
        PaymentTransaction.create!(:status_message => '',
                                   :user_purchase_id => other_user_purchase.id,
                                   :status_cd => 'Abandoned',
                                   :transaction_id => '',
                                   :amount => 0 )
      end

      @social_coupon = SocialCoupon.find(@message_id)

      @qty = 0
      coupons.each{|coupon|
        coupon['message_id'] = @message_id
        coupon['business_id'] = @social_coupon[:business_id]
        coupon['user_id'] = self[:user_id]
        @qty += 1
      }

      #@qty = coupons.count.to_i
      self['amount'] = @social_coupon.purchase_price * @qty
      self['purchase_status'] = 'pending'
    end
  end

  def update_social_coupon
    social_coupon_ids = []
    coupons.each{|coupon|
      social_coupon_ids << coupon.message_id unless social_coupon_ids.include?(coupon.message_id)
    }

    social_coupon_ids.each{|social_coupon_id|
      social_coupon = SocialCoupon.find(social_coupon_id)
      social_coupon.update_attribute(:quantity_purchased, SocialCoupon.sold.where(['coupons.message_id = ?', social_coupon_id]).count)
    }

  end

end
