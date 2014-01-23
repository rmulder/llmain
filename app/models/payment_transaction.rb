class PaymentTransaction < ActiveRecord::Base
  belongs_to :user_purchase

#  serialize :status_message
  before_save      JsonSerialized.new( :status_message )
  after_save       JsonSerialized.new( :status_message )
  after_find       JsonSerialized.new( :status_message )

  after_create :mark_cart

  before_validation :massage_data

  validates_with PaymentTransactionValidator

  private

  def mark_cart
    if status_cd == 'Cancelled'
      user_purchase.update_attributes(:purchase_status => 'failed')
    elsif status_cd == 'Abandoned'
      user_purchase.update_attributes(:purchase_status => 'failed')
      #Coupon.delete_all(:user_purchase_id => user_purchase.id)
    elsif status_cd == 'Refund - Cancelled'
      # do nothing
    elsif status_cd == 'Completed'
      user_purchase.update_attributes(:purchase_date => Time.now, :purchase_status => 'paid')
      # should add a confirmed flag to coupons
      # Coupon.update_all({:confirmed => true}, {:user_purchase_id => user_purchase.id})
    elsif status_cd == 'Refund'
      user_purchase.update_attributes(:purchase_status => 'refunded')
      # should add a confirmed flag to coupons
      # Coupon.update_all({:confirmed => false}, {:user_purchase_id => user_purchase.id})
    end
  end

  def massage_data
    if self.id.nil?
      self['amount'] = 0
      
      if self.status_cd == 'Completed'
        existing = PaymentTransaction.first(:conditions => {:user_purchase_id => self.user_purchase_id,
                                                            :status_cd => 'Completed'}, :select => 'id')
        if existing.present?
          self.status_cd = 'DuplicateNeedsRefund'
        end
      end

      if self.status_cd == 'Completed' || self.status_cd == 'Expired' || self.status_cd == 'Refund' || self.status_cd == 'DuplicateNeedsRefund'
        self['transaction_id'] = status_message[:tran_id] if !status_message[:tran_id].blank?
        self['amount'] = status_message[:tran_amount].to_f if !status_message[:tran_amount].blank?
      end
    end
  end
end
