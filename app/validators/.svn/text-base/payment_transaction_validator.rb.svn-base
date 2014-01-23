class PaymentTransactionValidator < ActiveModel::Validator
  def validate(record)
    if record.id.nil?
      minutes_ago = UserPurchase.first(:conditions => {:id => record.user_purchase_id},
                                       :select => 'TIMESTAMPDIFF(MINUTE, user_purchases.created_at, NOW()) minutes_ago')

      if minutes_ago.blank?
        record.errors[:user_purchase_id] << 'was not found'
        return
      end

      if record.status_cd == 'Completed' || record.status_cd == 'Expired' || record.status_cd == 'Refund'
        # check md5 encoded secret
        if record.status_message[:secret] !=
          Digest::MD5.hexdigest(
            record.user_purchase.coupons[0].message_id.to_s +
              '-' +
                record.user_purchase_id.to_s)
          record.errors[:user_purchase_id] << 'Invalid secret'
          return
        end

        if record.status_cd == 'Completed' || record.status_cd == 'Expired'
          if record.status_message[:invoice_number].blank? && # Merchant e-Services
            record.status_message[:transaction_id].blank? # Aria
            record.errors[:status_message] << 'Invoice number was not found'
          end

          if record.status_message[:tran_amount].to_f != record.user_purchase.amount.to_f
            record.errors[:amount] << 'Invalid invoice value'
          end

          # this needs to be handled properly - alert someone that there was a problem
          #if record.status_cd == 'Completed' &&
          #    minutes_ago.minutes_ago.to_i > SocialCouponsConfiguration::COUPON_CART_TIMEOUT
          # record.errors[:user_purchase_id] << 'Expired invoice'
          #end
        end
      end
    end
  end
end