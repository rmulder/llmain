class FriendList < ActiveRecord::Base
  set_table_name :tbl_friend_list
  set_primary_key :friends_list_id

  belongs_to :user, :primary_key => :id, :foreign_key => :from_user_id
  belongs_to :friend, :primary_key => :id, :foreign_key => :to_user_id

  scope :from_like_list, where(:friend_type => ["AlikeList", "LikeList"])
  scope :from_facebook, where(:friend_type => "Facebook")
end

