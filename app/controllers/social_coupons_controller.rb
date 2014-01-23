class SocialCouponsController < ApplicationController

  layout 'jquery'

  auto_complete_for :business, :business_name, {:select => 'business_name, business_id unique_id'}
  auto_complete_for :city, :city_name, {:select => "CONCAT(city_name, ', ', state_code) city_name, city_id unique_id"}

  # GET /social_coupons
  # GET /social_coupons.xml
  def index
    @social_coupons = SocialCoupon.all(:include => :business, :order => 'start_timestamp DESC', :conditions => ['TIMESTAMPDIFF(DAY, end_timestamp, NOW()) <= 60'])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @social_coupons }
      format.json  { render :json => @social_coupons }
    end
  end

  # GET /social_coupons/1
  # GET /social_coupons/1.xml
  def show
    @social_coupon = SocialCoupon.find(params[:id])
    @social_coupon['img_urls'] = []
    @social_coupon.images.each {|img|
      @social_coupon['img_urls'] << img.image.url(:medium)
    }

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @social_coupon }
      format.json  { render :json => @social_coupon }
    end
  end

  # GET /social_coupons/new
  # GET /social_coupons/new.xml
  def new
    @social_coupon = SocialCoupon.new
    # stub in the image in case they want to add one
    # we could do more than one if we liked
    1.times {@social_coupon.images.build}

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @social_coupon }
      format.json  { render :json => @social_coupon }
    end
  end

  # GET /social_coupons/1/edit
  def edit
    @social_coupon = SocialCoupon.find(params[:id])
    if @social_coupon.images.blank?
      1.times {@social_coupon.images.build}
    end
  end

  # POST /social_coupons
  # POST /social_coupons.xml
  def create
#    if !params[:social_coupon][:images_attributes].blank?
#      params[:social_coupon][:images_attributes].each{|image| image[1][:image].reference_type = 'SocialCoupon' }
#    end

    @social_coupon = SocialCoupon.new(params[:social_coupon])

    respond_to do |format|
      if @social_coupon.save
        format.html { redirect_to(@social_coupon, :notice => 'Social coupon was successfully created.') }
        format.xml  { render :xml => @social_coupon, :status => :created, :location => @social_coupon }
        format.json  { render :json => @social_coupon, :status => :created, :location => @social_coupon }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @social_coupon.errors, :status => :unprocessable_entity }
        format.json  { render :json => @social_coupon.errors, :status => :unprocessable_entity }

      end
    end
  end

  # PUT /social_coupons/1
  # PUT /social_coupons/1.xml
  def update
    @social_coupon = SocialCoupon.find(params[:id])

    respond_to do |format|
      if @social_coupon.update_attributes(params[:social_coupon])
        @social_coupon.images.each{|image|
          image.save
        }
        format.html { redirect_to(@social_coupon, :notice => 'Social coupon was successfully updated.') }
        format.xml  { head :ok }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @social_coupon.errors, :status => :unprocessable_entity }
        format.json  { render :json => @social_coupon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /social_coupons/1
  # DELETE /social_coupons/1.xml
  def destroy
    @social_coupon = SocialCoupon.find(params[:id])
    @social_coupon.destroy

    respond_to do |format|
      format.html { redirect_to(social_coupons_url) }
      format.xml  { head :ok }
    end
  end

  def check_status
    @social_coupon = SocialCoupon.first(:conditions => {:message_id => params[:id]}, :select => 'max_quantity_provided, TIMESTAMPDIFF(SECOND, NOW(), end_timestamp) time_left')

    if @social_coupon.blank?
      fail '404'
      return
    end

    sold_or_reserved_count = SocialCoupon.sold_or_reserved.where(['coupons.message_id = ?', params[:id]]).count
    @social_coupon[:quantity_purchased] = sold_or_reserved_count
    if !@social_coupon.max_quantity_provided
      @social_coupon[:quantity_remaining] = nil
    else
      @social_coupon[:quantity_remaining] = @social_coupon.max_quantity_provided - sold_or_reserved_count
    end

    time = @social_coupon['time_left'].to_i
    days = time / 86400
    hours = (time / 3600) - (days * 24)
    minutes = (time / 60) - (days * 1440) - (hours * 60)
    seconds = time % 60

    @social_coupon[:days_left] = days
    @social_coupon[:hours_left] = hours
    @social_coupon[:minutes_left] = minutes
    @social_coupon[:seconds_left] = seconds

    respond_to do |format|
      format.html { render :action => 'check_status', :layout => 'blank' }
      format.xml  { render :xml => @social_coupon }
      format.json  { render :json => @social_coupon }
    end
  end

  def deal_cities
    cities_out = {:cities => get_deal_cities}

    respond_to do |format|
      format.html { render :text => cities_out.to_json }
      format.xml  { render :xml => cities_out }
      format.json  { render :json => cities_out }
    end
  end

  # new version - return 0..max coupons randomly from the matching current deals
  def deals_of_the_day
    max = params[:max].blank? ? 1 : params[:max].to_i
    also_expired = params[:also_expired].present? && params[:also_expired].to_i > 0
    also_sf = params[:also_sf].present? && params[:also_sf].to_i > 0
    user_id = params[:user_id]
    radius = params[:radius].blank? ? 30 : params[:radius].to_i
    if params[:city_id].blank?
      city = params[:city].blank? ? '' : params[:city]
      state = params[:state].blank? ? '' : params[:state]
      state = state.split(/\s+/).each{ |word| word.capitalize! }.join(' ')
      city_record = City.first(:conditions => {:city_name => city, :state_code => state.upcase})
      if !city_record.blank?
        city_id = city_record.city_id
      else
        city_id = 0
      end
    else
      city_id = params[:city_id].to_i
    end

    social_coupons = SocialCoupon.find_by_city_and_radius(city_id, radius, max, also_expired, also_sf)

    @out = social_coupons.map{|social_coupon|
      social_coupon[:img_urls] = social_coupon.images.map {|img|
        img.image.url(:medium)
      };
      social_coupon.attributes}

    respond_to do |format|
      format.html { render :text => @out.to_json }
      format.xml  { render :xml => @out }
      format.json  { render :json => @out }
    end
  end

  # get the details for a single coupon
  def details
    radius = params[:radius].blank? ? 30 : params[:radius].to_i
    @out = SocialCoupon.details(params[:id], params[:user_id], radius)

    if @out.blank?
      fail '404'
      return
    end

		@out[:related_coupons] = SocialCoupon.related_coupons(params[:id], @out['city_id'], radius).
						map{|social_coupon| social_coupon.attributes.merge({:seo_link => social_coupon.seo_link})}

    respond_to do |format|
      format.html { render :text => @out.to_json }
      format.xml  { render :xml => @out }
      format.json  { render :json => @out }
    end
  end

  def campaign_overview
    csv = collect_campaign_overview_data(params[:id])

    respond_to do |format|
      format.html { render :text => csv.to_csv }
      format.csv  { render :text => csv.to_csv }
      format.xml  { render :xml => csv }
      format.json { render :json => csv }
    end
  end

  def campaign_details
    overview = collect_campaign_overview_data(params[:id])
    csv = []
    overview.each{|record|
      csv += collect_campaign_detail_data(record)
    }

    respond_to do |format|
      format.html { render :text => csv.to_csv }
      format.csv  { render :text => csv.to_csv }
      format.xml  { render :xml => overview }
      format.json { render :json => overview }
    end
  end

  def email_template
    @social_coupon = SocialCoupon.detail_data(params[:id])
    city_state = @social_coupon['city_name'].gsub(/ /, '-') + '-' + @social_coupon['state_code']
    @social_coupon['deal_perma_link'] = "#{AppConf.image_server}/deals/details/#{city_state}-#{params['id']}"

    links = YAML.load(File.read(File.join(::Rails.root.to_s, 'config', 'social_coupon_city_links.yml')))
    if links[city_state].present?
      social_links = links[city_state].symbolize_keys
    else
      social_links = links['default'].symbolize_keys
    end

    @social_coupon['deal_facebook_link'] = social_links[:facebook]
    @social_coupon['deal_twitter_link'] = social_links[:twitter]

    respond_to do |format|
      format.html { render :template => '/social_coupons/email/' + params[:template], :layout => false }
      format.text { render :template => '/social_coupons/email/' + params[:template] + '.html.erb', :layout => false }
    end
  end

  def payout_report
    @result = SocialCoupon.payout_report(params)

    csv = [['Business', 'Biz ID', 'Begin', 'End', 'Deal ID', 'Price', 'Sold', 'Refunded', 'Total']]
    csv = csv + @result.map{|campaign|
      [campaign.business_name, campaign.business_id, campaign.start_timestamp.to_s[0,10], campaign.end_timestamp.to_s[0,10], campaign.message_id, campaign.purchase_price, campaign.sold, campaign.refunded, campaign.total]
    }

    respond_to do |format|
      format.html { render }
      format.csv  { render :text => csv.to_csv }
      format.xml  { render :xml => csv }
      format.json { render :json => @result }
    end
  end

  private

  def collect_campaign_overview_data(id_or_date)
    out = []
    out << campaign_overview_data(0)
    if id_or_date.to_i.to_s == id_or_date
      out << campaign_overview_data(id_or_date)
    else
      date = Date.parse(id_or_date)
      social_coupons = SocialCoupon.all(:conditions => ["DATE_FORMAT(deal_end_timestamp, '%%Y-%%m-%%d 00:00:00') = '#{date} 00:00:00'"], :select => 'message_id', :order => 'business_id')
      social_coupons.each{|social_coupon|
        out << campaign_overview_data(social_coupon.message_id)
      }
    end
    out
  end

  def campaign_overview_data(id)
    if id == 0
      return ['business_name','business_id','business_address','business_address2',
              'business_city','business_state','business_zip','social_coupon_id',
              'coupon_description','qty_offered',
              'qty_sold','qty_purchases','value_sold',
              'amt_to_biz','qty_redeemed']
    end

    out = SocialCoupon.detail_data(id)
    coupons = Coupon.all(:conditions => ["coupons.message_id = #{id} and user_purchases.purchase_status = 'paid'"], :joins => :user_purchase).count

    [out['business']['business_name'], out['business']['business_id'], out['business']['address1'], out['business']['address2'],
     out['business']['city_name'], out['business']['state_code'], out['business']['zip_code'], out['message_id'],
     out['description'].truncate(50), out['max_quantity_provided'],
     coupons, out['purchase_count'], coupons * out['purchase_price'].to_f,
     coupons * out['purchase_price'].to_f * 0.96 * 0.50, 0]
  end

  def collect_campaign_detail_data(record)
    message_id = record[7]

    if message_id == 'social_coupon_id'
      return [record + ['coupon_id', 'user_purchase_id', 'coupon_unique_number', 'user_id', 'user_first_name', 'user_last_name',
                        'gift_flag', 'gift_first_name', 'gift_last_name', 'gift_email', 'coupon_created_at',
                        'purchase_date', 'purchase_status', 'amount',
                        'buyer_email']]
    end

    coupons = Coupon.all(:conditions => ["message_id = #{message_id} and purchase_status = 'paid'"], :joins => [:user_purchase, :user])

    count = 0
    out = coupons.map{|coupon|
      count += 1
      (count == 1 ? record : [''] * record.count) +
                             [coupon.id, coupon.user_purchase_id, coupon.coupon_unique_number, coupon.user_id, coupon.user.first_name, coupon.user.last_name,
                              coupon.gift_flag, coupon.first_name, coupon.last_name, coupon.email_address, coupon.created_at,
                              coupon.user_purchase.purchase_date, coupon.user_purchase.purchase_status, coupon.social_coupon.purchase_price,
                              coupon.user_purchase.buyer_email]
    }
    out
  end

end