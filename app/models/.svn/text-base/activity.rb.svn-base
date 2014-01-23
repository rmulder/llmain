class Activity < ActiveRecord::Base

  def self.addActivity(activity_type, data)
puts data.to_json
		subject_type = data['subject_type'].blank? ? owner_type_business.downcase : data['subject_type']
		actArr = {
			'subject_type' => subject_type,
			'subject_id' => data['entry_id'].to_i,
			'activity_owner_type' => owner_type_user.downcase,
			'activity_group' => 'like',
			'activity_type' => activity_type,
			'activity_date' => Time.now,
			'user_id' => data['owner_id']
		}

		if data['city_id'].blank?
			if actArr['subject_type'] == owner_type_business.downcase
				bis = Business.first(:conditions => {:business_id => data['entry_id']}, :select => 'city_id')
				actArr['city_id'] = bis.city_id
			end
		else
			actArr['city_id'] = data['city_id'].to_i
		end

		case activity_type
			when actvty_type_addtolist
				actArr['activity_group'] = actvty_subject_type_list
				actArr['source_activity_id'] = data['list_entry_list_id']
			when actvty_type_join
				actArr['activity_group'] = owner_type_user.downcase
				actArr['source_activity_id'] = data['owner_id']
				if actArr['city_id'].present?
					unset(actArr['city_id'])
				end
			when message_type_message, message_type_offer, message_type_third_party, message_type_social_coupon
				actArr['activity_owner_type'] = owner_type_business.downcase
				actArr['activity_group'] = list_entry_type_deal.downcase
				actArr['source_activity_id'] = data['message_id']
				actArr['start_timestamp'] = data['start_timestamp']
				actArr['end_timestamp'] = data['end_timestamp']
			when actvty_type_claim
				actArr['activity_owner_type'] = owner_type_business.downcase
				actArr['activity_group'] = actvty_group_news
				actArr['source_activity_id'] = data['smb_entity_id']
			when list_type_custom, actvty_type_follow
				actArr['activity_owner_type'] = owner_type_user.downcase
				actArr['activity_group'] = actvty_subject_type_list
				actArr['source_activity_id'] = data['source_activity_id']
			else
				actArr['source_activity_id'] = data['list_entry_id']
		end

		return self.create(actArr)

  end

  def self.updateActivity(data, city_id=nil, start_timestamp=nil, end_timestamp=nil)
		if data['activity_type'] == message_type_message || data['activity_type'] == message_type_offer || data['activity_type'] == message_type_third_party
			row = first(:conditions => data)
			if row.blank?
				arr = {
					'entry_id' => data['subject_id'],
					'message_id' => data['source_activity_id'],
					'start_timestamp' => start_timestamp,
					'end_timestamp' => end_timestamp,
					'city_id' => city_id,
					'owner_id' => nil
				}
				return addActivity(data['activity_type'], arr)
			else
				row.update_attributes({
						'activity_date' => Time.now,
						'start_timestamp' => start_timestamp,
						'end_timestamp' => end_timestamp,
					})
				return true
			end
		end

		if data['activity_type'] == actvty_type_tip
			tipdata = {
				'subject_id' => data['entry_id'],
				'source_activity_id' => data['list_entry_id'],
				'activity_type' => data['activity_type']
			}
			row = first(:conditions => tipdata)
			if row.blank?
				return addActivity(data['activity_type'], data)
			else
				row.update_attributes({'activity_date' => Time.now})
				return true
			end
		end

	end

  def self.message_type_message
		'message'
  end
  def self.message_type_offer
		'offer'
  end
  def self.message_type_third_party
		'third_party_offer'
  end
  def self.message_type_social_coupon
		'SocialCoupon'
  end
  def self.actvty_subject_type_list
		 'list'
  end
  def self.actvty_group_news
		'news'
  end
  def self.actvty_group_user
		'user'
  end
  def self.actvty_group_purchase
		'purchase'
  end

  def self.actvty_type_tip
		'comment'
  end
  def self.actvty_type_join
		'join'
  end
  def self.actvty_type_claim
		'activation'
  end
  def self.actvty_type_addtolist
		'new_item'
  end
  def self.actvty_type_follow
		'follow'
  end
  def self.actvty_likelist_bizid
		13804976
  end
  def self.actvty_messagetype_tip
		'tip'
  end
  def self.actvty_messagetype_deal
		'deal'
  end
  def self.actvty_messagetype_coupon
		'coupon'
  end
  def self.actvty_messagetype_news
		'news'
  end
  def self.actvty_message_maxlen
		75
  end
  def self.owner_type_user
		'User'
  end
  def self.owner_type_business
		'Business'
  end
  def self.list_entry_type_business
		'Business'
  end
  def self.list_entry_type_deal
		'Deal'
  end
  def self.list_type_default
		'DefaultList'
  end
  def self.list_type_custom
		'CustomList'
  end
  def self.list_type_top
		'TopList'
  end

end
