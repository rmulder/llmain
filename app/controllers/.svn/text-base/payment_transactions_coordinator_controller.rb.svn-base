class PaymentTransactionsCoordinatorController < ApplicationController
  
  layout 'jquery'

  def duplicates_needing_refunds
    @payment_transactions = PaymentTransaction.all(:conditions => {:status_cd => 'DuplicateNeedsRefund'},
                                                   :include => {:user_purchase => [:user, {:coupons => :social_coupon}]})
  end

end
