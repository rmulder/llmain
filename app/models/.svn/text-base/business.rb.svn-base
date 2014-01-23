class Business < ActiveRecord::Base
  require 'addressable/uri'
  require 'nokogiri'
  require 'open-uri'

  cattr_reader :per_page
  @@per_page = 10

  set_table_name "tbl_businesses"
  set_primary_key :business_id

  before_save :set_reindex

  has_one :promo_site
  has_many :promo_messages

  has_many :likes, :foreign_key => 'entry_business_id'
  has_many :trys, :foreign_key => 'entry_business_id'
  has_many :social_coupons

  belongs_to :city
  belongs_to :business_type
  belongs_to :category

  def id
    business_id
  end

  def images
    begin
      check_website(self.website)
    rescue
      Array.new
    end
  end

  def google_images
    url = "http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=%s"
    url = sprintf url, self.business_name
    logger.debug "trying URL #{url}"
    check_website url, 'google'
  end

  def get_image
    #promo_site = PromoSite.first(:conditions => {:business_id => id}, :select => 'logo_image_file_path')
    #if promo_site && promo_site.logo_image_file_path.present? && FileTest.exists?(AppConf.image_file_path + AppConf.image_path_square100 + promo_site.logo_image_file_path.to_s)
    #  return AppConf.image_server + AppConf.image_url + AppConf.image_path_square100 + promo_site.logo_image_file_path
    #end

    if default_image_file_path.present? && FileTest.exists?(AppConf.image_file_path + AppConf.image_path_square100 + default_image_file_path.to_s)
      return AppConf.image_server + AppConf.image_url + AppConf.image_path_square100 + default_image_file_path
    end
    #biz_type = BizToBizType.first(:conditions => {:business_id => id, :is_primary => 'y'}, :select => 'level1')

    #if biz_type && biz_type.level1
    #  if L1_IMAGES_ARR[biz_type.level1.to_i].present? && FileTest.exists?(AppConf.avatar_file_path + L1_IMAGES_ARR[biz_type.level1.to_i])
    #    return AppConf.image_server + AppConf.avatar_image_url + L1_IMAGES_ARR[biz_type.level1.to_i]
    #  end
    #end

    AppConf.image_server + NO_PROMO_IMAGE
  end

  def get_image_by_values(logo_image_file_path, biz_type_level1)

    business_logger = Logger.new('log/business_logger.log')
    business_logger.info "get_image_by_values #{logo_image_file_path} #{biz_type_level1}"
    # List Image
    # Photo of Owner
    # Default

	  if logo_image_file_path.present? && FileTest.exists?(AppConf.image_file_path + AppConf.image_path_square100 + logo_image_file_path.to_s)
	    return AppConf.image_server + AppConf.image_url + AppConf.image_path_square100 + logo_image_file_path.to_s
	  end

	  if default_image_file_path.present? && FileTest.exists?(AppConf.image_file_path + AppConf.image_path_square100 + default_image_file_path.to_s)
	    return AppConf.image_server + AppConf.image_url + AppConf.image_path_square100 + default_image_file_path
	  end

	  if biz_type_level1.present? &&
	    L1_IMAGES_ARR[biz_type_level1.to_i].present? &&
			FileTest.exists?(AppConf.avatar_file_path + L1_IMAGES_ARR[biz_type_level1.to_i])
	      return AppConf.image_server + AppConf.avatar_image_url + L1_IMAGES_ARR[biz_type_level1.to_i]
	  end

	  AppConf.image_server + NO_PROMO_IMAGE
  end


  # these three functions are needed by the avatar tool
  # and need to have business_rating refactored out of them
  # special find_by_sql usage to optimize getting a specific result set needed for photo upload app
  def self.find_top_ranked_businesses_without_pictures (page=1)
    paginate_by_sql "SELECT COUNT(entry_business_id) AS like_count, entry_business_id business_id FROM list_entries WHERE type = 'Like' GROUP BY entry_business_id ORDER BY like_count DESC", :page => page
  end

  def self.get_details_for_list_of_business_ids(list)

#    is there a better way to do it?
#    businesses = Business.joins(:list_entries, :cities).select("a.business_name, a.address1, a.address2,
#                                                   a.zip_code, a.state_code, a.business_id,
#                                                   a.website, a.default_image_file_path,
#                                                   count(b.businesses_id) as like_count,
#                                                   c.logo_image_file_path, d.city_name")
#    result = businesses.all
    list = list.map {|obj| obj['business_id'].to_i}.join(",")
    # yes, I know a prepared statement would be the best way to do this...but it's not supported in Rails 2.3.5 currently
    # technically bogus, but not a security risk because there is no way for user data to get in here
    query = "SELECT a.business_name, a.address1, a.address2, a.zip_code, a.state_code, a.business_id, a.website, " +
         "a.default_image_file_path, COUNT(b.entry_business_id) AS like_count, c.logo_image_file_path, d.city_name  " +
         "FROM tbl_businesses as a LEFT OUTER JOIN list_entries AS b ON a.business_id = b.entry_business_id AND b.type = 'Like' " +
         "LEFT OUTER JOIN smb_promo_sites AS c ON a.business_id = c.business_id " +
         "LEFT OUTER JOIN tbl_cities AS d ON a.city_id = d.city_id WHERE a.business_id IN (" + list + ") " +
         "GROUP BY a.business_name ORDER BY like_count DESC"
    find_by_sql query
  end

  def self.find_all_businesses_in_zip (page=1, list="95066")
    # yes, I know a prepared statement would be the best way to do this...but it's not supported in Rails 2.3.5 currently
    # technically bogus, but not a security risk because there is no way for user data to get in here
    query = "SELECT a.business_name, a.address1, a.address2, a.zip_code, a.state_code, a.business_id, a.website, " +
            "a.default_image_file_path, count(b.entry_business_id) as like_count, c.logo_image_file_path, d.city_name  " +
            "FROM tbl_businesses as a LEFT OUTER JOIN list_entries as b ON a.business_id = b.entry_business_id AND b.type = 'Like' " +
            "LEFT OUTER JOIN smb_promo_sites AS c ON a.business_id = c.business_id " +
            "LEFT OUTER JOIN tbl_cities as d ON a.city_id = d.city_id WHERE a.zip_code IN (" + list + ") " +
            "GROUP BY a.business_name ORDER BY like_count desc"
    paginate_by_sql query, :page => page
  end

  def canonicalized_website
    canonicalize website unless website.nil? || website.strip == ""
  end

  def comments
    comments = []
    top_3_ids = [0, 0, 0]
    if self.promo_site.present? && self.promo_site.cust_comment1_user_id.present?
      top_3_ids = [self.promo_site.cust_comment1_user_id, self.promo_site.cust_comment2_user_id, self.promo_site.cust_comment3_user_id]
    end

    top_3_comments = []
    other_comments = []
    ratings = self.likes.
        joins(:comment).
        joins("inner join users on users.id = owner_id").
        select('profile_photo_path, first_name, last_name, owner_id user_id, comments, list_entries.updated_at rated_on').
        order('list_entries.updated_at desc')

    ratings.each{|rating|
      if top_3_ids.include?(rating.user_id.to_i)
        top_3_comments << rating.attributes.merge(:top_3 => top_3_ids.index(rating.user_id.to_i))
      else
        other_comments << rating.attributes
      end
    }

    if !top_3_comments.blank?
      comments = top_3_comments.sort_by{|rating| rating['top_3'].to_i}
    end

    other_comments.each {|rating| comments << rating}

    comments
  end

  def likes_near(city_id, radius)
    likes.near(city_id, radius).with_comments.
    select('profile_photo_path, first_name, last_name, owner_id user_id, comments, list_entries.updated_at rated_on').
    order('list_entries.updated_at desc')
  end

  def attributes_for_coupons()
    self.attributes.merge({
        'avatar' => get_image,
        'slogan' => promo_site.blank? ? '' : promo_site.slogan,
        'business_summary' => promo_site.blank? ? '' : promo_site.business_summary,
        'what_makes_us_different' => promo_site.blank? ? '' : promo_site.what_makes_us_different,
        'logo_image_file_path' => promo_site.blank? ? '' : promo_site.logo_image_file_path,
        'cust_comment1_user_id' => promo_site.blank? ? '' : promo_site.cust_comment1_user_id,
        'cust_comment2_user_id' => promo_site.blank? ? '' : promo_site.cust_comment2_user_id,
        'cust_comment3_user_id' => promo_site.blank? ? '' : promo_site.cust_comment3_user_id,
        'city_name' => city.city_name,
        'state_code' => city.state_code
      })
    #      out[:business].delete('city')
  end

  private

  def set_reindex
    logger.debug "----->setting 're-index' flag to 'Y' ..."
    reindex = 'Y'
  end


  def check_website(url, type='normal')

    images = Array.new

    return images if url.blank?

    url = canonicalize url

    doc_str = String.new

    open("#{url}") { |f|
      f.each_line { |line| doc_str = doc_str + line }
    }

    logger.debug "--->document returned is #{doc_str.length} characters long"
    #logger.debug doc_str

    if type == 'google' || type == 'google_page'
      doc = ActiveSupport::JSON.decode(doc_str)['responseData']

      doc['results'].each do |node|
        images << node['unescapedUrl']
      end
      if type == 'google'
        doc['cursor']['pages'].each do |page|
          if page['start'].to_i > 0
            check_website(url + '&start=' + page['start'], 'google_page').each do |image|
              images << image
            end
          end
        end
      end
    else
      doc = Nokogiri::HTML(doc_str)
      uri_root = Addressable::URI.parse(url)

      logger.debug "---->found #{doc.css('img').count} image tags"

      doc.css('img').each do |node|
        #logger.info node.to_s
        # need to handle images server off other sites!
        this_node = node.attributes['src'].to_s
        if begins_with_http this_node
          images << this_node
        else
          images << uri_root.to_s + this_node
        end

      end
    end

    logger.info images.to_yaml
    images

  end

  def begins_with_http(uri)
    uri.lstrip.slice(0, 7).downcase == "http://"
  end

  def canonicalize(uri)
    # make sure we have the protocol specified
    uri = "http://".concat(uri) unless begins_with_http(uri)
    uri = Addressable::URI.parse(uri).normalize
    uri.to_s
  end

end
