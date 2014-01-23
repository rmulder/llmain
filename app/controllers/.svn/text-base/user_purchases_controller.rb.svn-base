class UserPurchasesController < ApplicationController
  protect_from_forgery :except => [:purchase, :purchase_callback, :refund_callback]
  skip_filter :http_basic, :only => [:purchase_callback, :refund_callback]

  def index
    if !params[:user_id].blank?
      user_purchases = UserPurchase.all(
                           :conditions => ["purchase_status in ('paid','refunded') and user_id = ?", params[:user_id]],
                           :order => 'created_at')
    elsif !params[:message_id].blank?
      user_purchases = UserPurchase.all(:joins => :user,
                           :conditions => ["purchase_status in ('paid','refunded') and exists (select 1 from coupons c where c.user_purchase_id = user_purchases.id and c.message_id = ?)", params[:message_id]],
                           :order => 'users.last_name, users.first_name, created_at')
    else
      fail :user_id => 'missing user id or message id'
      return
    end

    if user_purchases.blank?
      fail '404'
      return
    end

    @user_purchases = []
    user_purchases.each{|user_purchase|
      coupons = []
      user_purchase.coupons.each{|coupon|
        coupons << {:coupon => coupon.serializable_hash,
                    :business => coupon.social_coupon.business.serializable_hash,
                    :social_coupon => coupon.social_coupon.serializable_hash}
      }

      @user_purchases << {:user_purchase => user_purchase.serializable_hash,
                          :coupons => coupons,
                          :user => user_purchase.user.serializable_hash}
    }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_purchases }
      format.json  { render :json => @user_purchases }
    end
  end

  def show
    @user_purchase = user_purchase_details(params[:id])
    respond_to do |format|
      format.html { render :text => @user_purchase }
      format.xml  { render :xml => @user_purchase }
      format.json { render :json => @user_purchase }
    end
  end

  def purchase_test
    @user_id = 1
    @social_coupon = SocialCoupon.find(params[:id])
    @coupon = Coupon.new
  end

  def purchase
    # handle cases where user_purchase is passed as an array of a hash instead of a hash
    if params[:user_purchase].kind_of? Array
      params[:user_purchase] = params[:user_purchase][0]
    end

    if !params[:coupons_attributes].blank?
      params[:user_purchase][:coupons_attributes] = params[:coupons_attributes]
    end

    err = nil
    UserPurchase.transaction do
      begin
        @user_purchase = UserPurchase.new params[:user_purchase]
        if !@user_purchase.save
          err = @user_purchase.errors
          raise ActiveRecord::Rollback
        end
      rescue ActiveRecord::StatementInvalid => e
        err = {'error' => e.to_s}
        raise ActiveRecord::Rollback
      rescue ActiveRecord::RecordNotFound => e
        err = {'message_id' => e.to_s}
        raise ActiveRecord::Rollback
      end
    end

    fail err and return if !err.blank?

    respond_to do |format|
      values = {
        :user_purchase_id => @user_purchase.id.to_s,
        :message_id => @user_purchase.message_id.to_s,
        :client_sku => AppConf.aria_inv_item_deal,
        :units => @user_purchase.coupons.count,
        :amount_each => @user_purchase.coupons[0].social_coupon['purchase_price'],
        :amount => @user_purchase[:amount],
        :secret => Digest::MD5.hexdigest(@user_purchase.coupons[0].message_id .to_s + '-' + @user_purchase.id.to_s)
      }
      # puts 'VALUES: ' + values.to_json

      format.html { values.to_json }
      format.xml  { render :xml => values }
      format.json { render :json => values }
    end
  end

  def purchase_callback
    status_cd = ''
    if params[:resp_code].present? # Merchant e-services
      status_cd = params[:resp_code] == '000' ? 'Completed' : 'CardFailure'
    else                           # ARIA
      status_cd = params[:error_msg] == 'OK' ? 'Completed' : 'CardFailure'
    end

    payment_transaction =
      PaymentTransaction.new(:status_message => params,
                             :user_purchase_id => params[:id],
                             :status_cd => status_cd)

    # create the payment record
    if payment_transaction.save
      # all good - let's go
      @user_purchase = user_purchase_details(params[:id])
      respond_to do |format|
        format.html { render :text => 'OK' }
        format.xml  { render :xml => @user_purchase }
        format.json { render :json => @user_purchase }
      end
      return
    end

    # if this was an expired invoice, make expired payment transaction record
    if !payment_transaction.errors[:user_purchase_id].blank? &&
      payment_transaction.errors[:user_purchase_id][0] == 'Expired invoice'

      exp_transaction =
        PaymentTransaction.new(:status_message => params,
                               :user_purchase_id => params[:id],
                               :status_cd => 'Expired')
      exp_transaction.save
    end

    fail payment_transaction.errors
  end

  def cancel_callback
    # todo implement Secret here too
    payment_transaction =
      PaymentTransaction.new(:status_message => params,
                             :user_purchase_id => params[:id],
                             :status_cd => 'Cancelled',
                             :amount => 0)

    # create the payment record
    if payment_transaction.save
      # all good - let's go
      respond_to do |format|
        format.html { render :text => payment_transaction }
        format.xml  { render :xml => {:trans_status => 'OK'} }
        format.json { render :json => {:trans_status => 'OK'} }
      end
    else
      fail payment_transaction.errors
    end
  end

  def refund
    raise' "Missing Invoice ID"' if params[:id].blank?
    # get the coupon purchase record in question
    user_purchase = UserPurchase.find(params[:id])
    # get the IPN record for this purchase
    payment_transaction = PaymentTransaction.first(:conditions => {:user_purchase_id => user_purchase.id}, :order => 'created_at desc')
puts 'transaction ' + payment_transaction.to_json
    raise 'Invalid Invoice ID' if payment_transaction.blank?

    coupons = Coupon.all(:conditions => {:user_purchase_id => params[:id]})
puts 'coupons ' + coupons.to_json
    raise 'No coupons' if coupons.blank?

    # build a transaction to refund the entire payment transaction
    values = {
      :profile_id => MES_CONFIG[:mes_profile_id],
      :transaction_type => 'U',
      #:logo_url => request.protocol + request.host_with_port + '/images/likelistlogo.png',
      :logo_url => 'https://www.likelist.com/images/alikelist.png',
      :css_url => 'https://www.likelist.com/resources/css/mes_gateway.css',
      # md5 of the coupon and purchase IDs as a secret to verify the IPN callback later
      :return_url => refund_complete_url(coupons[0].message_id.to_s),
      :response_url => refund_callback_url(:id => user_purchase.id, :secret => Digest::MD5.hexdigest(coupons[0].message_id.to_s + '-' + user_purchase.id.to_s)).gsub(/\:[0-9]{2,4}/, ''),
      :cancel_url => cancel_refund_callback_url(:id => user_purchase.id, :secret => Digest::MD5.hexdigest(coupons[0].message_id .to_s + '-' + user_purchase.id.to_s)).gsub(/\:[0-9]{2,4}/, ''),
      :invoice_number => coupons[0].message_id.to_s + '-' + user_purchase.id.to_s,
      :client_reference_number => user_purchase.user_id,
      :transaction_amount => user_purchase.amount,
      :transaction_id => payment_transaction.transaction_id
    }
    # puts 'POSTED VALUES: ' + values.to_json
    # puts 'PAYPAL_CONFIG VALUES: ' + PAYPAL_CONFIG.to_json

    headers['Status'] = '302 Found'
    redirect_to MES_CONFIG[:mes_url] + '?' + values.map { |k,v| "#{k}=#{CGI::escape(v.to_s)}"  }.join('&')
  end

  def refund_callback
    payment_transaction =
      PaymentTransaction.new(:status_message => params,
                             :user_purchase_id => params[:id],
                             :status_cd => 'Refund')

    # create the payment record
    if payment_transaction.save
      # all good - let's go
      respond_to do |format|
        format.html { render :text => payment_transaction }
        format.xml  { render :xml => {:trans_status => 'OK'} }
        format.json { render :json => {:trans_status => 'OK'} }
      end
    else
      fail payment_transaction.errors
    end
  end

  def cancel_refund_callback
    payment_transaction =
      PaymentTransaction.new(:status_message => params,
                             :user_purchase_id => params[:id],
                             :status_cd => 'RefundCancelled',
                             :amount => 0)

    # create the payment record
    if payment_transaction.save
      # all good - let's go
      respond_to do |format|
        format.html { render :text => payment_transaction }
        format.xml  { render :xml => {:trans_status => 'OK'} }
        format.json { render :json => {:trans_status => 'OK'} }
      end
    else
      fail payment_transaction.errors
    end
  end

  def refund_complete
    redirect_to('/user_purchases?message_id=' + params[:id].to_s)
  end

  private

  def user_purchase_details(id)
    user_purchase = UserPurchase.find(params[:id], :include =>[ :user, { :coupons => { :social_coupon => :business } } ] )

    user_purchase_out = user_purchase.serializable_hash
    if !user_purchase.user.blank?
      user_purchase_out[:user] = user_purchase.user.serializable_hash
      user_purchase_out[:user][:password] = nil
      snp = SocialNetworkProfile.first(
          :conditions => {:user_id => user_purchase.user.id,
                          :sn_id => user_purchase.user.preferred_sn_id})
      user_purchase_out[:user][:email_id] = snp.present? ? snp.email : ''
    else
      user_purchase_out[:user] = {:id => 0, :error => 'missing'}
    end
    user_purchase_out[:coupons] = []
    user_purchase.coupons.each {|coupon|
      coupon_hash = coupon.serializable_hash
      coupon_hash[:social_coupon] = coupon.social_coupon.serializable_hash
      coupon_hash[:social_coupon][:business] = coupon.social_coupon.business.serializable_hash
      user_purchase_out[:coupons] << coupon_hash
    }

    user_purchase_out
  end

end
