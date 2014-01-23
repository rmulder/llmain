=begin
 * Searchupdate_Model -
 *
 * PHP Version 5
 *
 * @project  LikeList
 * @category Models
 * @package  AL_Model
 * @author   Manish Khanchandani <manish@likelist.com>
 * @license  copyright 2010 AlikeList
 * @version  SVN: <svn_id>
 * @link     http://www.likelist.com/
=end

=begin
 * Class: Searchupdate_Model
 *
 * @category Models
 * @package  Models
 * @author   Manish Khanchandani <manish@likelist.com>
 * @license  copyright 2010 AlikeList
 * @link     http://www.likelist.com/
=end
class SearchUpdateModel
=begin
	/**
	 * business_listing_to_solr function to update index in solr
	 *
	 * @param integer business_id business id to update
	 * @param integer start_ts    start timestamp of business
	 * @param integer end_ts      end timestamp of business
	 *
	 * @author unknown <unknown@alikelist.com>
	 *
	 * @return boolean
	 */
=end
	def self.business_listing_to_solr(business_id, start_ts, end_ts)
		if delete_business_listing_from_solr(business_id)
		  if add_business_listing_to_solr(business_id, start_ts, end_ts)
		    return true
      end
    end

    return false
	end # business_listing_to_solr()


=begin
	 * add_business_listing_to_solr function to add index
	 *
	 * @param integer business_id business id to update
	 * @param integer start_ts    start timestamp of business
	 * @param integer end_ts      end timestamp of business
	 *
	 * @author unknown <unknown@alikelist.com>
	 *
	 * @return boolean
=end
	def self.add_business_listing_to_solr(business_id, start_ts, end_ts)
		get_business_data_sql = 'SELECT b.`business_id` AS business_id, b.`business_name` AS business_name,
			b.`business_type_id` AS business_type_id, b.`city_id` AS city_id, b.`state_code` AS state_code,
			b.`business_phone` AS business_phone, replace(b.`business_info`,"\n","") as business_info,
			b.`zip_code` AS zip_code, b.`latitude` AS latitude, b.`longitude` AS longitude,
			b.`address1` AS address1, b.`address2` AS address2, b.`business_user_id` AS business_user_id,
			b.`business_secondary_phone` AS business_secondary_phone, b.`business_tertiary_phone` AS business_tertiary_phone,
			/*t.business_type_name_path, */t.business_type_name,
			b.`modified_on` AS modified_on
			FROM tbl_businesses AS b
      LEFT JOIN business_types AS t ON b.`business_type_id` = t.`id`
			WHERE b.business_id = ' + business_id.to_s
#biz.`business_type_path_seq` AS business_type_path_seq,  t.`business_type_path` AS business_type_path,
#      LEFT JOIN tbl_biz_to_biz_types AS biz ON b.`business_id` = biz.`business_id`

		business_query_array = Business.find_by_sql get_business_data_sql
		# puts business_query_array.to_json

		#temp_business_type_name_path = business_query_array[0]['business_type_name_path'] # previously business_type_path_seq
		#temp_business_type_name_path_array = temp_business_type_name_path.split('/')

		temp_blob = business_query_array[0]['business_name'].to_s + ' ' + business_query_array[0]['business_type_name'].to_s
#		temp_blob = business_query_array[0]['business_name'].to_s + ' ' + business_query_array[0]['business_type_path'].to_s
		temp_blob = temp_blob.gsub(/\//, ' ').gsub(/\&/, ' ').gsub(/\,/, ' ').gsub(/\;/, ' ').gsub(/\s+/, ' ')

		temp_b = business_query_array[0]['business_name'].to_s.gsub(/\//, ' ').gsub(/\&/, ' ').gsub(/\,/, ' ').gsub(/\;/, ' ').gsub(/\s+/, ' ')

		# temp_bi = business_query_array[0]['business_info'].to_s.gsub(/\//, ' ').gsub(/\&/, ' ').gsub(/\,/, ' ').gsub(/\;/, ' ').subst(/\s+/, ' ')

		add_business_xml = '<add><doc>' +
			'<field name="_l1">0</field>' +
			'<field name="_l2">0</field>' +
			'<field name="_l3">0</field>' +
			'<field name="_l4">0</field>' +
			#'<field name="_l1">' + temp_business_type_name_path_array[0].to_s + '</field>' +
			#'<field name="_l2">' + temp_business_type_name_path_array[1].to_s + '</field>' +
			#'<field name="_l3">' + temp_business_type_name_path_array[2].to_s + '</field>' +
			#'<field name="_l4">' + temp_business_type_name_path_array[3].to_s + '</field>' +
			'<field name="_l5">0</field>' +
			'<field name="_l6">0</field>' +
			'<field name="_l7">0</field>' +
			'<field name="_l8">0</field>' +
			'<field name="blob">' + temp_blob.to_s + '</field>' +
			'<field name="business_id">' + business_id.to_s + '</field>' +
			'<field name="business_name">' + temp_b.to_s + '</field>' +
			'<field name="business_phone">' + business_query_array[0]['business_phone'].to_s + '</field>' +
			'<field name="business_secondary_phone">' + business_query_array[0]['business_secondary_phone'].to_s + '</field>' +
			'<field name="business_tertiary_phone">' + business_query_array[0]['business_tertiary_phone'].to_s + '</field>' +
			'<field name="business_type_id">' + start_ts.to_s + '</field>' +
			'<field name="city_id">' + business_query_array[0]['city_id'].to_s + '</field>' +
			'<field name="latitude">' + business_query_array[0]['latitude'].to_s + '</field>' +
			'<field name="likes">' + end_ts.to_s + '</field>' +
			'<field name="longitude">' + business_query_array[0]['longitude'].to_s + '</field>' +
			'<field name="state_code">' + business_query_array[0]['state_code'].to_s + '</field>' +
			'<field name="zip_code">' + business_query_array[0]['zip_code'].to_s + '</field>' +
		'</doc></add>'

		server_call = 'http://' + AppConf.solr_host + ':' + AppConf.solr_port.to_s + '/solr/update'
    form_data = {'stream.body' => add_business_xml}
    begin
      result = Net::HTTP.post_form(URI.parse(server_call), form_data)
    rescue Exception => e
      ActiveRecord::Base.logger.error "Error updating solr @ #{AppConf.solr_host}:#{AppConf.solr_port.to_s} - #{e.message}"
      return false
    end
    #puts 'updated ok'
    ActiveRecord::Base.logger.info 'XML:' + add_business_xml
    #puts server_call
    #puts result.body
		return true
	end # add_business_listing_to_solr()


=begin
	 * delete_business_listing_from_solr function to delete listing
	 *
	 * @param integer business_id business id to update
	 *
	 * @author unknown <unknown@alikelist.com>
	 *
	 * @return boolean
=end
	def self.delete_business_listing_from_solr(business_id)
		stream_body = URI.escape('<delete><query>business_id:' + business_id.to_s + '</query></delete>')
		begin
      result = Net::HTTP.start(AppConf.solr_host, AppConf.solr_port) {|http|
        http.get('/solr/update?wt=json&stream.body=' + stream_body)
      }
    rescue Exception => e
      ActiveRecord::Base.logger.error "Error deleting from solr @ #{AppConf.solr_host}:#{AppConf.solr_port.to_s} - #{e.message}"
      return false
    end
    #puts 'deleted ok'
    #puts result.body
		return true
	end # delete_business_listing_from_solr()

end # class