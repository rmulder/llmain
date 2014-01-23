class DefaultList < List
  # ensure that any user may have at most one DefaultList
  validates_uniqueness_of :owner_id, :scope => [:type], :message => "Users may only have one DefaultList"

  # temp fix for undefined method problem in paperclip gem likely due to STI: super doesn't work
  def avatar_content_type
    false
  end

end
