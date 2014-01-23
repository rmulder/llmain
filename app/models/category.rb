class Category < ActiveRecord::Base

  set_table_name "tbl_business_types"
  set_primary_key :category_id
  
  has_many :businesses

  def id
    category_id
  end

end