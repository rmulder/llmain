class BusinessType < ActiveRecord::Base

  set_table_name "tbl_business_types"
  set_primary_key :business_type_id
  
  has_many :businesses

  def id
    business_type_id
  end

  def business_type_path_parsed
	  business_type_path.split('/').pop(2).join(', ')
  end

end