class RedisModel
  def self.search_connection
    @search_connection ||= Redis.new(
      :host => AppConf.search_redis_host,
      :port => AppConf.search_redis_port,
      :db => AppConf.search_redis_db
    )
  end

  def self.member_connection
    @member_connection ||= Redis.new(
      :host => AppConf.search_redis_host,
      :port => AppConf.search_redis_port,
      :db => AppConf.member_redis_db
    )
  end

#	/**
#	 * findMembers action - Return user matches based on keywords for MemberFinder auto-complete
#	 *
#	 * @param string  $keywords Keyword
#	 * @param integer $limit    Limit on first name, last name or first/last name matches
#	 * @param integer $offset   Starting index
#	 * @param boolean $id_only  Flag to return user_id or name:user_id array; if > 1, returns name:user_id as array index
#	 *
#	 * @author Luis DeGuzman <luis@alikelist.com>
#	 *
#	 * @return nothing
#	 */
	def self.findMembers(keywords)
    keywords = keywords.downcase.gsub(/[^a-z0-9\s-]/, '').strip
    if keywords.empty?
      return false
		end

    keywords_without_spaces = keywords.gsub(/\s+/, '')
    keywords_with_single_spaces = keywords.gsub(/\s+/, ' ')
    tokens = keywords_with_single_spaces.split(' ')
    
    begin
      members = member_connection.zrange(keywords_without_spaces, 0, 200)
      #ActiveRecord::Base.logger.info members.to_yaml
      users = members.uniq.collect{|member| spl = member.split(':'); spl[1].to_i}
      return {:users => users, :tokens => tokens}
		#rescue
			#member_connection.logRedisError($e);
    end
    
	end # findMembers()

end
