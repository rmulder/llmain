class BizToBizType < ActiveRecord::Base

  set_table_name "tbl_biz_to_biz_types"
  belongs_to :business
  belongs_to :business_type

end