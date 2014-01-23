class Try < ListEntry
  
   belongs_to :friend, :class_name => "FriendList", :foreign_key => :owner_id
  
end
