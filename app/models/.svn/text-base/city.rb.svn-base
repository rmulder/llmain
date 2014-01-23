class City < ActiveRecord::Base

  set_table_name "tbl_cities"
  set_primary_key :city_id
  
  has_many :social_coupons
  has_many :businesses
  has_many :promo_messages

  def id
    city_id
  end

end