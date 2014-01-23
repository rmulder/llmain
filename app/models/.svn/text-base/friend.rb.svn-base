class Friend < User

  # setup relationships
  # write the code you wish you had, i.e.. -- User.find(148).friends.like_business(:business_id)
  belongs_to :location
  has_many :lists, :primary_key => :to_user_id, :foreign_key=>:owner_id

  # end experimental relations

end
