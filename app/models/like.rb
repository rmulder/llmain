class Like < ListEntry

  scope :near, lambda {|city_id, radius|
    joins("inner join users on users.id = owner_id").
    joins("inner join tbl_city_distance cd on cd.city_id = users.location_id and cd.radius = #{radius.to_i} and cd.near_city_id = #{city_id.to_i}")}

  scope :with_comments, joins("LEFT JOIN comments ON comments.list_entry_id = list_entries.id")

end
