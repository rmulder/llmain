class JobQueue < ActiveRecord::Base
  set_table_name "tbl_job_queue"

  belongs_to :authentication, :foreign_key => 'social_network_profile_id'
end
