class UserPurchaseValidator < ActiveModel::Validator
  def validate(record)
    if record.id.nil?
      existing_purchase = UserPurchase.first(:joins => :coupons,
                                             :conditions => "user_purchases.user_id = #{record.user_id} and " +
                                                            "coupons.message_id = #{record.message_id} and " +
                                                            "user_purchases.purchase_status = 'paid'")

      if !existing_purchase.blank?
        record.errors[:message_id] << 'has been purchased once already'
      else
        sold_or_reserved_count = SocialCoupon.sold_or_reserved.where(['coupons.message_id = ?', record.message_id]).count

        record.errors[:qty] << 'is greater than allowed per purchase' if
            record.qty > record.social_coupon.max_quantity_per_person

        record.errors[:qty] << 'is fewer than allowed per purchase' if
            record.qty < record.social_coupon.min_quantity_per_person

        record.errors[:qty] << 'is greater than left for purchase' if
            record.social_coupon.max_quantity_provided &&
            record.qty > record.social_coupon.max_quantity_provided - sold_or_reserved_count
      end
    end
  end
end