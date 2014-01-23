class CouponsController < ApplicationController
  def show
    begin
      if params[:id].to_i.to_s == params[:id].to_s
        coupon = Coupon.find(params[:id])
      else
        coupon = Coupon.first(:conditions => {:coupon_unique_number => params[:id]})
      end
    rescue ActiveRecord::RecordNotFound => e
    end

    if coupon.blank?
      fail '404'
      return
    end

    @out = {:coupon => coupon.serializable_hash,
            :user => coupon.user.serializable_hash,
            :business => coupon.social_coupon.business.serializable_hash,
            :social_coupon => coupon.social_coupon.serializable_hash,
            :qr_code => self.qr_code(coupon.id)}

    @out[:business][:city_name] = coupon.social_coupon.business.city.city_name
    @out[:business][:state_code] = coupon.social_coupon.business.city.state_code
    @out[:business].delete('city')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @out}
      format.json  { render :json => @out}
    end
  end

  def qr_code(id)
    return ''
    # let's not clutter up the results with this yet

    if id.to_i.to_s == id.to_s
      @coupon = Coupon.find(id)
    else
      @coupon = Coupon.first(:conditions => {:coupon_unique_number => id})
    end

    if !@coupon.blank?
      @qr = RQRCode::QRCode.new('http://www.likelist.com/redeem/' + @coupon.coupon_unique_number, :size => 6, :level => :h )
      render_to_string :partial => 'qr_code'
    else
      ''
    end
  end

  def index
    scope = Coupon
    if params[:user_id].present?
      scope = scope.where(["coupons.user_id = ?", params[:user_id]])
    end
    if params[:message_id].present?
      scope = scope.where(["coupons.message_id = ?", params[:message_id]])
    end
    if params[:purchase_status].present?
      scope = scope.where(["purchase_status = ?", params[:purchase_status]])
    end

    social_coupons = nil
    if !params[:user_id].blank?
      user = User.find(params[:user_id])
      social_coupons = SocialCoupon.find_by_city_and_radius(user.location_id, 100, 1, false, false)
      if social_coupons.present?
        social_coupons.map! do |social_coupon|
          city_state = social_coupon.city.city_name.gsub(/ /, '-') + '-' + social_coupon.city.state_code
          "#{city_state}-#{social_coupon.id}"
        end
      end
    end

    @coupons = []
    if params[:user_id].present?
      coupons = scope.all(
                          :joins => :user_purchase,
                          :order => 'created_at',
                          :include => [
                            {:user_purchase => :user},
                            {:social_coupon => :city}
                          ])

      coupons.each do |coupon|
        @coupons << {
                     :coupon => coupon.serializable_hash,
                     :user => coupon.user.serializable_hash,
                     :business => coupon.social_coupon.business.serializable_hash,
                     :social_coupon => coupon.social_coupon.serializable_hash,
                     :qr_code => self.qr_code(coupon.id)
        }
      end
    end

    @response =  { :total => @coupons.count, :coupons => @coupons, :deal => social_coupons }
    respond_to do |format|
      format.html
      format.xml  { render :xml => @response }
      format.json  { render :json => @response }
    end
  end

end
