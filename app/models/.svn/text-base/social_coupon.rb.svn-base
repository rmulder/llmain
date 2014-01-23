class SocialCoupon < PromoMessage
  has_many :coupons, :foreign_key  => :message_id

  belongs_to :business
  belongs_to :city
  belongs_to :transaction_term

  accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['image'].nil? }

  scope :sold_or_reserved,
        joins(:coupons).joins('inner join user_purchases on coupons.user_purchase_id = user_purchases.id').where("purchase_status = 'paid' OR (purchase_status = 'pending' AND TIMESTAMPDIFF(MINUTE, user_purchases.created_at, NOW()) < ?)", SocialCouponsConfiguration::COUPON_CART_TIMEOUT)

  scope :sold,
        joins(:coupons).joins('inner join user_purchases on coupons.user_purchase_id = user_purchases.id').where("purchase_status = 'paid'")

  default_value_for :transaction_term_id, TransactionTerm.first(:conditions => ["effective_start_date <= NOW() AND effective_end_date >= NOW()"], :select => 'id').try(:id)
  default_value_for :quantity_purchased, 0

  def id
    message_id
  end

  # for right now we only want to deal in whole day increments
  # so let's make some accessors to hide the time portion from the user
  def start_timestamp
    read_attribute(:start_timestamp).blank? ? Time.now : read_attribute(:start_timestamp).to_time.in_time_zone(AppConf.user_time_zone)
  end

  def start_timestamp=(value)
    if !value.blank?
      value = value.to_time.in_time_zone(AppConf.user_time_zone).beginning_of_day.advance(:days => 1)
    end
    write_attribute(:start_timestamp, value)
  end

  def end_timestamp
    read_attribute(:end_timestamp).blank? ? Time.now : read_attribute(:end_timestamp).to_time.in_time_zone(AppConf.user_time_zone)
  end

  def end_timestamp=(value)
    if !value.blank?
      value = value.to_time.in_time_zone(AppConf.user_time_zone).end_of_day.advance(:days => 1)
    end
    write_attribute(:end_timestamp, value)
  end

  def deal_start_timestamp
    read_attribute(:deal_start_timestamp).blank? ? Time.now : read_attribute(:deal_start_timestamp).to_time.in_time_zone(AppConf.user_time_zone)
  end

  def deal_start_timestamp=(value)
    if !value.blank?
      value = value.to_time.in_time_zone(AppConf.user_time_zone).beginning_of_day.advance(:days => 1)
    end
    write_attribute(:deal_start_timestamp, value)
  end

  def deal_end_timestamp
    read_attribute(:deal_end_timestamp).blank? ? Time.now : read_attribute(:deal_end_timestamp).to_time.in_time_zone(AppConf.user_time_zone)
  end

  def deal_end_timestamp=(value)
    if !value.blank?
      value = value.to_time.in_time_zone(AppConf.user_time_zone).end_of_day.advance(:days => 1)
    end
    write_attribute(:deal_end_timestamp, value)
  end

  def seo_link
	  city.city_name.gsub(/ /, '-').downcase + '-' + city.state_code.upcase + '-' + id.to_s
  end

  class << self
    include Cacheify

    # cacheable helper functions

    def find_by_city_and_radius(city_id, radius, max, also_expired=true, also_san_francisco=true)
      # find what they are looking for
      social_coupons = get_random_coupons(
                  find_all_records_by_city_and_radius(city_id, 0, false),
                  max)

      # if we didn't find enough current in that city, find an expired one in that city
      if social_coupons.count < max && also_expired
        ids = social_coupons.map{|social_coupon| social_coupon.message_id}
        get_random_coupons(
          find_all_records_by_city_and_radius(city_id, 0, true),
          max - social_coupons.count, ids).
          each{|social_coupon| social_coupons << social_coupon}
      end

      # if we didn't find enough in that city, find something near that city
      if social_coupons.count < max && radius > 0
	      # work our way from 5 to radius miles
	      [5,10,30,100].each{|rad|
		      if social_coupons.count < max && radius >= rad
						ids = social_coupons.map{|social_coupon| social_coupon.message_id}
						get_random_coupons(
              find_all_records_by_city_and_radius(city_id, rad, false),
              max - social_coupons.count, ids).
              each{|social_coupon| social_coupons << social_coupon}
		      end
	      }
      end

      # if we didn't find enough current near that city, find an expired one near that city
      if social_coupons.count < max && radius > 0 && also_expired
        ids = social_coupons.map{|social_coupon| social_coupon.message_id}
        get_random_coupons(
            find_all_records_by_city_and_radius(city_id, radius, true),
            max - social_coupons.count, ids).
            each{|social_coupon| social_coupons << social_coupon}
      end

      # if we didn't find enough near that city, find something current in SF
      if social_coupons.count < max && radius > 0 && also_san_francisco
        ids = social_coupons.map{|social_coupon| social_coupon.message_id}
        get_random_coupons(
            find_all_records_by_city_and_radius(218325, 0, false),
            max - social_coupons.count, ids).
            each{|social_coupon| social_coupons << social_coupon}
      end

      # if we didn't find enough current in SF, find something expired in SF
      if social_coupons.count < max && radius > 0 && also_expired && also_san_francisco
        ids = social_coupons.map{|social_coupon| social_coupon.message_id}
        get_random_coupons(
            find_all_records_by_city_and_radius(218325, 0, true),
            max - social_coupons.count, ids).
            each{|social_coupon| social_coupons << social_coupon}
      end

      social_coupons
    end

    # return up to max random coupons from the social coupons array
    # and skip any where message_id is in ids array
    def get_random_coupons(social_coupons, max, ids=[])
      choose_from = []
      social_coupons.each{|social_coupon|
        if ids.include?(social_coupon.message_id)
          break
        end
        choose_from << social_coupon
      }

      # grab at most max random records
      choose_from.sample(max)
    end

		# cacheable routine to return all current coupons for a given city and radius
    def find_all_records_by_city_and_radius(city_id, radius, also_expired)
      select = 'message_id, smb_promo_messages.city_id, one_min_message, business_name, purchase_price, max_quantity_per_person, retail_value, tbl_cities.city_name, tbl_cities.state_code'
      if radius == 0
        if !also_expired
          all(:conditions => ["smb_promo_messages.city_id = ? and start_timestamp <= NOW() AND end_timestamp >= NOW()", city_id],
							:joins => [:business, :city],
              :select => select)
        else
          all(:conditions => ["smb_promo_messages.city_id = ? and end_timestamp < NOW()", city_id],
              :joins => [:business, :city],
              :select => select)
        end
      else
	      # create a sql safe join string.
	      # *had to include :business in the string since using the force index broke the joins array method
        # *:business can go back to the all() call below now that we are not forcing the index anymore
        joins_string = ActiveRecord::Base.send("sanitize_sql_array", ["INNER JOIN tbl_city_distance " +
                         "ON tbl_city_distance.near_city_id = smb_promo_messages.city_id " +
                         "AND radius = ? AND tbl_city_distance.city_id = ? " +
                         "INNER JOIN tbl_businesses ON tbl_businesses.business_id = smb_promo_messages.business_id " +
                         "INNER JOIN tbl_cities ON tbl_cities.city_id = smb_promo_messages.city_id",
                                                                        radius, city_id ])

        if !also_expired
          all(:joins => joins_string,
              :conditions => ["start_timestamp <= NOW() AND end_timestamp >= NOW()"],
              :select => select)
        else
          all(:joins => joins_string,
              :conditions => ["end_timestamp < NOW()"],
              :select => select)
        end
      end
    end

    cacheify :find_all_records_by_city_and_radius, :expires_in => 1.minute

    # collect details about the coupon
		def details(id, user_id, radius)
      # load models so cacheify can marshal properly
      #PromoSite
      Business
      Image

      # load the coupon detail data
			data = detail_data(id)

			if data.blank?
				return
			end

			# load the possibly cacheable user data
			user_data = detail_user_data(id, data['business_id'], user_id)
			biz_data = detail_biz_data(data['business_id'], data['city_id'], radius)

			out = {}

			# this should not be cached
				if user_id.present?
					existing_purchase = UserPurchase.first(:joins => :coupons,
																								 :conditions => "user_purchases.user_id = #{user_id} and " +
																																"coupons.message_id = #{id} and " +
																																"user_purchases.purchase_status = 'paid'")

					out[:already_purchased] = !existing_purchase.blank?
			end

				out.merge(data).merge(user_data).merge(biz_data)
		end

		# the cacheable data for a user related to a coupon
		def detail_user_data(id, business_id, user_id)
			out = {}

			if user_id.present?
				user = User.find(user_id)
				out[:friend_likes] = []
				ratings = user.friends_who_like_business_id(business_id)
				ratings[0..4].each{|rating|
					out[:friend_likes] << rating.attributes
				}
				out[:friend_likes_count] = ratings.count

				out[:friend_trys] = []
				ratings = user.friends_who_want_to_try_business_id(business_id)

				ratings[0..4].each{|rating|
					out[:friend_trys] << rating.attributes
				}
				out[:friend_trys_count] = ratings.count

				# does the current user like or want to try this business?
				list_entry = ListEntry.first(:conditions => {
																				:owner_id => user_id,
																				:entry_business_id => business_id
																			}, :select => 'type')
				out[:like_business] = list_entry.present? && list_entry.type == 'Like'
				out[:try_business] = list_entry.present? && list_entry.type == 'Try'
			end

			out
		end

		cacheify :detail_user_data, :expires_in => 1.minute

		def detail_biz_data(business_id, city_id, radius)
			out = {}

			business = Business.find(business_id, :select => 'business_id')

			out[:local_likes] = []
			radius = radius.blank? ? 30 : radius.to_i

			ratings = business.likes_near(city_id, radius)

			ratings[0..4].each{|rating|
				out[:local_likes] << rating.attributes
			}
			out[:local_likes_count] = ratings.to_a.count

			comments = []
			ratings = business.comments
			out[:comments_count] = ratings.count
			ratings[0..9].each{|rating| comments << rating}
			out[:comments] = comments

			out
		end

		#cacheify :detail_biz_data, :expires_in => 1.minute

    # new version - properly nests business data under social coupon data
    def detail_data(id)
			social_coupon = detail_data_cached(id)
			if social_coupon.blank?
				return nil
			end

			sold_or_reserved_count = SocialCoupon.sold_or_reserved.where(['coupons.message_id = ?', id]).count
      social_coupon['quantity_purchased'] = sold_or_reserved_count
      if social_coupon['max_quantity_provided'].blank?
        social_coupon['quantity_remaining'] = nil
        social_coupon['sold_out'] = false
      else
        social_coupon['quantity_remaining'] = social_coupon['max_quantity_provided'] - sold_or_reserved_count
        social_coupon['sold_out'] = social_coupon['quantity_remaining'] <= 0
      end

      social_coupon['purchase_count'] = SocialCoupon.sold.
          where(['smb_promo_messages.message_id = ?',id]).
          select('distinct user_purchases.id').
          count
			
      time = social_coupon['time_left'].to_i
      days = time / 86400
      hours = (time / 3600) - (days * 24)
      minutes = (time / 60) - (days * 1440) - (hours * 60)
      seconds = time % 60

      social_coupon['days_left'] = days
      social_coupon['hours_left'] = hours
      social_coupon['minutes_left'] = minutes
      social_coupon['seconds_left'] = seconds

			social_coupon
		end

    def detail_data_cached(id)
      social_coupon = first(:conditions => {:message_id => id},
                            :joins => :transaction_term,
                            :include => {:business => :promo_site},
                            :select => 'smb_promo_messages.*, TIMESTAMPDIFF(SECOND, NOW(), end_timestamp) time_left, terms likelist_terms')

      if social_coupon.blank?
        return nil
      end

      social_coupon[:img_urls] = social_coupon.images.map {|img|
        img.image.url(:medium)
      }

      social_coupon[:city_name] = social_coupon.city.city_name
      social_coupon[:state_code] = social_coupon.city.state_code

      social_coupon[:business] = social_coupon.business.attributes_for_coupons

      social_coupon.attributes
    end

    cacheify :detail_data_cached, :expires_in => 1.minute

    def get_deal_cities
      # get all cities which have had a deal start before right now
      deal_cities = SocialCoupon.all(:joins => :city,
                                     :conditions => ["start_timestamp < NOW()"],
                                     :select => 'DISTINCT city_name, state_code, tbl_cities.city_id')

      cities_out = []
      deal_cities.each{|city| cities_out << city.attributes}

      cities_out
    end

    cacheify :get_deal_cities, :expires_in => 1.minute

		def related_coupons(id, city_id, radius)
			social_coupons = find_all_records_by_city_and_radius(city_id, radius, false)
			out = []
			social_coupons.each{|social_coupon|
				if social_coupon.message_id.to_i != id.to_i
					out << social_coupon
				end
			}
		  out
		end

		cacheify :related_coupons, :expires_in => 1.minute

    def payout_report(params)
      scope = select(
        "business_name, b.business_id, start_timestamp, end_timestamp, message_id, purchase_price,
        (select count(*) from coupons
          inner join user_purchases on coupons.user_purchase_id = user_purchases.id
          where user_purchases.purchase_status = 'paid'
          and coupons.message_id = smb_promo_messages.message_id) sold,
        (select count(*) from coupons
          inner join user_purchases on coupons.user_purchase_id = user_purchases.id
          where user_purchases.purchase_status = 'refunded'
          and coupons.message_id = smb_promo_messages.message_id) refunded,
        (
          (select count(*) from coupons
            inner join user_purchases on coupons.user_purchase_id = user_purchases.id
            where user_purchases.purchase_status = 'paid'
            and coupons.message_id = smb_promo_messages.message_id)
          -
          (select count(*) from coupons
            inner join user_purchases on coupons.user_purchase_id = user_purchases.id  where
            user_purchases.purchase_status = 'refunded'
            and coupons.message_id = smb_promo_messages.message_id)
        ) * purchase_price total")

      scope = scope.order("start_timestamp, end_timestamp")

      scope = scope.joins("inner join tbl_businesses b on smb_promo_messages.business_id = b.business_id")

      if params[:business_id].present?
        scope = scope.where("b.business_id = #{params[:business_id].to_i}")
      end
      if params[:id].present?
        scope = scope.where("message_id = #{params[:id].to_i}")
      end
      scope
    end

  end

end
