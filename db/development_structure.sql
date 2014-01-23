CREATE TABLE SN_Activities (
  id int(10) NOT NULL AUTO_INCREMENT,
  date_added timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  user_id int(10) NOT NULL,
  sn_id int(10) NOT NULL,
  business_id int(10) NOT NULL,
  api_used varchar(100) NOT NULL,
  event_id int(11) NOT NULL,
  response_code varchar(100) NOT NULL,
  status enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

CREATE TABLE SN_Activities_history (
  history_id int(20) NOT NULL AUTO_INCREMENT,
  history_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  history_reason enum('deleted','merged','updated') NOT NULL DEFAULT 'updated',
  id int(10) NOT NULL,
  date_added timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  user_id int(10) NOT NULL,
  sn_id int(10) NOT NULL,
  business_id int(10) NOT NULL,
  api_used varchar(100) NOT NULL,
  event_id int(11) NOT NULL,
  response_code varchar(100) NOT NULL,
  status enum('Y','N') NOT NULL DEFAULT 'N',
  merge_to_business_id int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (history_id)
) ENGINE=MyISAM AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

CREATE TABLE SN_Events (
  id int(10) NOT NULL AUTO_INCREMENT,
  description varchar(100) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE category_keywords (
  keyword varchar(255) CHARACTER SET utf8 NOT NULL,
  business_type_id int(20) NOT NULL,
  level_id int(11) NOT NULL,
  PRIMARY KEY (keyword)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE category_keywords_copy (
  keyword varchar(255) NOT NULL,
  business_type_id int(20) NOT NULL,
  level_id int(11) NOT NULL,
  PRIMARY KEY (keyword)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE comments (
  id int(11) NOT NULL AUTO_INCREMENT,
  list_entry_id int(11) NOT NULL,
  comments mediumtext NOT NULL,
  created_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY fk_comments_list_items (list_entry_id),
  CONSTRAINT fk_comments_list_items FOREIGN KEY (list_entry_id) REFERENCES list_entries (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=65553 DEFAULT CHARSET=latin1;

CREATE TABLE coupons (
  id int(11) NOT NULL AUTO_INCREMENT,
  coupon_unique_number char(10) DEFAULT NULL,
  message_id int(11) NOT NULL,
  business_id int(11) DEFAULT NULL,
  user_purchase_id int(11) DEFAULT NULL,
  redeemed_date timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  user_id int(11) DEFAULT NULL,
  gift_flag tinyint(4) DEFAULT '0',
  first_name varchar(45) DEFAULT NULL,
  last_name varchar(45) DEFAULT NULL,
  email_address varchar(255) DEFAULT NULL,
  created_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY coupon_unique_number_UNIQUE (coupon_unique_number),
  KEY fk_tbl_coupons_tbl_user_deal_purchases1 (user_purchase_id),
  CONSTRAINT fk_tbl_coupons_tbl_user_deal_purchases1 FOREIGN KEY (user_purchase_id) REFERENCES user_purchases (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE dbiz (
  deleted_business_id int(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE entry_sources (
  id int(11) NOT NULL AUTO_INCREMENT,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  source_name varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE faqs (
  id int(11) NOT NULL AUTO_INCREMENT,
  subject varchar(255) DEFAULT NULL,
  text text,
  link varchar(255) DEFAULT NULL,
  display_order int(2) DEFAULT '1',
  faq_type enum('smb','consumer') DEFAULT 'smb',
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

CREATE TABLE faqs_web_pages (
  id int(11) NOT NULL AUTO_INCREMENT,
  faq_id int(11) NOT NULL,
  web_page_id int(11) NOT NULL,
  created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY fk_faqs_to_web_pages_web_page_id (web_page_id),
  CONSTRAINT fk_faqs_to_web_pages_web_page_id FOREIGN KEY (web_page_id) REFERENCES web_pages (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

CREATE TABLE list_entries (
  id int(11) NOT NULL AUTO_INCREMENT,
  entry_type enum('Like','Try') NOT NULL,
  entry_id int(11) NOT NULL,
  data_source_id smallint(6) NOT NULL,
  created_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=80763 DEFAULT CHARSET=latin1;

CREATE TABLE list_entries_lists (
  id int(11) NOT NULL AUTO_INCREMENT,
  list_id int(11) NOT NULL,
  list_entry_id int(11) NOT NULL,
  created_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY fk_list_entries_lists_map_list_entries (list_entry_id),
  KEY fk_list_entries_lists_map_lists (list_id),
  CONSTRAINT fk_list_entries_lists_map_list_entries FOREIGN KEY (list_entry_id) REFERENCES list_entries (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_list_entries_lists_map_lists FOREIGN KEY (list_id) REFERENCES lists (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=267045 DEFAULT CHARSET=latin1;

CREATE TABLE lists (
  id int(20) NOT NULL AUTO_INCREMENT,
  user_id int(20) NOT NULL,
  type enum('DefaultList','CustomList') NOT NULL,
  list_name varchar(255) NOT NULL DEFAULT 'Like List',
  list_description text,
  created_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY fk_tbl_lists_tbl_users (user_id),
  CONSTRAINT fk_tbl_lists_tbl_users FOREIGN KEY (user_id) REFERENCES tbl_users (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=50644 DEFAULT CHARSET=latin1;

CREATE TABLE marketing_campaign_businesses (
  id int(11) NOT NULL AUTO_INCREMENT,
  campaign varchar(50) NOT NULL,
  activation_code varchar(50) DEFAULT NULL,
  business_name varchar(255) NOT NULL,
  business_id int(20) NOT NULL,
  address1 varchar(255) DEFAULT NULL,
  city_name varchar(255) DEFAULT NULL,
  state_code varchar(2) DEFAULT NULL,
  zip_code varchar(10) DEFAULT NULL,
  business_type_name varchar(100) DEFAULT NULL,
  delivery_method varchar(50) DEFAULT NULL,
  delivery_date datetime DEFAULT '0000-00-00 00:00:00',
  activation_code_used_flag tinyint(1) NOT NULL DEFAULT '0',
  activation_code_used_timestamp datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id),
  UNIQUE KEY activation_code_UNIQUE (activation_code)
) ENGINE=MyISAM AUTO_INCREMENT=30126 DEFAULT CHARSET=utf8;

CREATE TABLE payment_transactions (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_purchase_id int(11) NOT NULL,
  amount decimal(10,2) NOT NULL,
  transaction_id varchar(45) DEFAULT NULL,
  status_cd varchar(255) NOT NULL DEFAULT '0',
  status_message text,
  created_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY fk_payment_transactions_user_deal_purchases (user_purchase_id),
  CONSTRAINT fk_payment_transactions_user_deal_purchases FOREIGN KEY (user_purchase_id) REFERENCES user_purchases (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE schema_migrations (
  version varchar(255) NOT NULL,
  UNIQUE KEY unique_schema_migrations (version)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE seo_url_mappings (
  url_mapping_id int(10) NOT NULL AUTO_INCREMENT,
  inbound_url varchar(255) NOT NULL,
  outbound_url varchar(255) NOT NULL,
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (url_mapping_id),
  KEY inbound_url_index (inbound_url)
) ENGINE=MyISAM AUTO_INCREMENT=10898 DEFAULT CHARSET=utf8;

CREATE TABLE smb_accounts (
  account_id int(20) NOT NULL AUTO_INCREMENT,
  account_name varchar(255) NOT NULL,
  primary_user_id int(20) NOT NULL,
  secondary_user_id int(20) DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  version tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (account_id),
  KEY fk_smb_accounts_tbl_users1 (secondary_user_id),
  KEY fk_smb_accounts_tbl_users2 (primary_user_id)
) ENGINE=MyISAM AUTO_INCREMENT=14317 DEFAULT CHARSET=utf8;

CREATE TABLE smb_accounts_history (
  history_id int(20) NOT NULL AUTO_INCREMENT,
  history_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  history_reason enum('deleted','updated') NOT NULL DEFAULT 'updated',
  account_id int(20) NOT NULL,
  account_name varchar(255) NOT NULL,
  primary_user_id int(20) NOT NULL,
  secondary_user_id int(20) DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  version tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (history_id),
  KEY account_id_index (account_id),
  KEY fk_smb_accounts_tbl_users1 (secondary_user_id),
  KEY fk_smb_accounts_tbl_users2 (primary_user_id)
) ENGINE=MyISAM AUTO_INCREMENT=102759 DEFAULT CHARSET=utf8;

CREATE TABLE smb_aria_provisioning_details (
  provisioning_detail_id int(20) NOT NULL AUTO_INCREMENT,
  business_entity_id int(20) NOT NULL,
  business_id int(20) NOT NULL,
  aria_plan_no bigint(20) NOT NULL DEFAULT '0',
  aria_account_no int(20) DEFAULT NULL,
  aria_user_id varchar(100) NOT NULL,
  aria_status_cd int(10) NOT NULL,
  aria_promo_cd varchar(30) DEFAULT NULL,
  aria_error_code int(20) DEFAULT NULL,
  aria_error_msg varchar(255) DEFAULT NULL,
  provisioning_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (provisioning_detail_id),
  KEY business_entity_id_index (business_entity_id),
  KEY aria_status_cd_index (aria_status_cd),
  KEY business_id_index (business_id)
) ENGINE=MyISAM AUTO_INCREMENT=111959 DEFAULT CHARSET=utf8;

CREATE TABLE smb_aria_provisioning_statuses (
  aria_status_cd int(10) NOT NULL,
  aria_status_label varchar(100) NOT NULL,
  PRIMARY KEY (aria_status_cd)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE smb_business_entities (
  business_entity_id int(20) NOT NULL AUTO_INCREMENT,
  business_name varchar(255) NOT NULL,
  city_id int(20) NOT NULL DEFAULT '0',
  state_code varchar(2) DEFAULT NULL,
  account_id int(20) NOT NULL,
  address1 varchar(255) DEFAULT NULL,
  address2 varchar(255) DEFAULT NULL,
  primary_phone varchar(20) NOT NULL DEFAULT '0',
  zip_code varchar(10) DEFAULT NULL,
  current_provisioning_detail_id int(20) DEFAULT NULL,
  current_provisioning_source enum('aria') DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  version tinyint(4) DEFAULT NULL,
  PRIMARY KEY (business_entity_id),
  KEY account_id_index (account_id)
) ENGINE=MyISAM AUTO_INCREMENT=104422 DEFAULT CHARSET=utf8;

CREATE TABLE smb_business_entities_history (
  history_id int(20) NOT NULL AUTO_INCREMENT,
  history_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  history_reason enum('deleted','updated') NOT NULL DEFAULT 'updated',
  business_entity_id int(20) NOT NULL,
  business_name varchar(255) NOT NULL,
  city_id int(20) NOT NULL DEFAULT '0',
  state_code varchar(2) DEFAULT NULL,
  account_id int(20) NOT NULL,
  address1 varchar(255) DEFAULT NULL,
  address2 varchar(255) DEFAULT NULL,
  primary_phone varchar(20) NOT NULL,
  zip_code varchar(10) DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  version tinyint(4) DEFAULT '1',
  PRIMARY KEY (history_id),
  KEY business_entity_id_index (business_entity_id),
  KEY account_id_index (account_id)
) ENGINE=MyISAM AUTO_INCREMENT=16421 DEFAULT CHARSET=utf8;

CREATE TABLE smb_categories (
  category_id int(20) NOT NULL AUTO_INCREMENT,
  category_name varchar(100) NOT NULL,
  source enum('Acxiom SYPH','Localeze Normalized Heading','SMB provided','AlikeList') NOT NULL,
  source_id int(20) DEFAULT NULL,
  PRIMARY KEY (category_id),
  KEY source_id_index (source_id)
) ENGINE=MyISAM AUTO_INCREMENT=25921 DEFAULT CHARSET=utf8;

CREATE TABLE smb_created_business_listings (
  smb_bl_id int(20) NOT NULL AUTO_INCREMENT,
  business_name varchar(255) NOT NULL,
  business_type_id int(20) NOT NULL DEFAULT '0',
  business_user_id bigint(20) NOT NULL DEFAULT '0',
  address1 varchar(255) DEFAULT NULL,
  address2 varchar(255) DEFAULT NULL,
  city_id int(20) NOT NULL DEFAULT '0',
  state_code varchar(2) DEFAULT NULL,
  zip_code varchar(10) DEFAULT '0',
  business_phone varchar(20) DEFAULT NULL,
  business_secondary_phone varchar(20) DEFAULT NULL,
  business_tertiary_phone varchar(20) DEFAULT NULL,
  website varchar(255) DEFAULT NULL,
  business_info varchar(255) DEFAULT NULL,
  latitude double DEFAULT '0',
  longitude double DEFAULT '0',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  is_deleted enum('Y','N') DEFAULT 'N',
  city varchar(255) DEFAULT NULL,
  is_rated char(1) DEFAULT 'N',
  source_external_id varchar(50) NOT NULL DEFAULT '0',
  user_entered_category varchar(255) DEFAULT NULL,
  PRIMARY KEY (smb_bl_id),
  KEY city_id_index (city_id),
  KEY latitude_index (latitude),
  KEY longitude_index (longitude),
  KEY state_code_index (state_code),
  KEY zip_code_index (zip_code),
  KEY business_phone_index (business_info),
  KEY source_external_index (source_external_id)
) ENGINE=MyISAM AUTO_INCREMENT=14401 DEFAULT CHARSET=utf8;

CREATE TABLE smb_dashboards (
  smb_dashboard_id int(20) NOT NULL AUTO_INCREMENT,
  business_id int(20) NOT NULL,
  business_entity_id int(20) DEFAULT NULL,
  business_listing_impressions_last_day int(10) NOT NULL DEFAULT '0',
  business_listing_click_thrus_last_day int(10) NOT NULL DEFAULT '0',
  clicks_on_url_last_day int(10) NOT NULL DEFAULT '0',
  business_listing_impressions_this_week int(10) NOT NULL DEFAULT '0',
  business_listing_click_thrus_this_week int(10) NOT NULL DEFAULT '0',
  clicks_on_url_this_week int(10) NOT NULL DEFAULT '0',
  business_listing_impressions_last_week int(10) NOT NULL DEFAULT '0',
  business_listing_click_thrus_last_week int(10) NOT NULL DEFAULT '0',
  clicks_on_url_last_week int(10) NOT NULL DEFAULT '0',
  business_listing_impressions_this_month int(10) NOT NULL DEFAULT '0',
  business_listing_click_thrus_this_month int(10) NOT NULL DEFAULT '0',
  clicks_on_url_this_month int(10) NOT NULL DEFAULT '0',
  business_listing_impressions_last_month int(10) NOT NULL DEFAULT '0',
  business_listing_click_thrus_last_month int(10) NOT NULL DEFAULT '0',
  clicks_on_url_last_month int(10) NOT NULL DEFAULT '0',
  business_listing_impressions_total int(10) NOT NULL DEFAULT '0',
  business_listing_click_thrus_total int(10) NOT NULL DEFAULT '0',
  clicks_on_url_total int(10) NOT NULL DEFAULT '0',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  last_update timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (smb_dashboard_id),
  UNIQUE KEY business_id_index (business_id),
  KEY business_entity_id_index (business_entity_id)
) ENGINE=MyISAM AUTO_INCREMENT=118035 DEFAULT CHARSET=utf8;

CREATE TABLE smb_dashboards_wrk (
  logging_event_id int(10) NOT NULL,
  business_id int(20) NOT NULL,
  event_count int(10) NOT NULL DEFAULT '0',
  logging_event_name varchar(100) DEFAULT NULL,
  event_date date NOT NULL DEFAULT '0000-00-00',
  UNIQUE KEY event_business_date_index (logging_event_id,business_id,event_date),
  KEY business_id_index (business_id),
  KEY logging_event_id_index (logging_event_id),
  KEY logging_event_name_index (logging_event_name)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE smb_faqs_bkup (
  id int(11) NOT NULL AUTO_INCREMENT,
  subject varchar(255) DEFAULT NULL,
  text text,
  link varchar(255) DEFAULT NULL,
  display_order int(2) DEFAULT '1',
  pages varchar(255) DEFAULT NULL,
  faq_type enum('smb','consumer') DEFAULT 'smb',
  PRIMARY KEY (id),
  FULLTEXT KEY pages (pages)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

CREATE TABLE smb_issue_topics (
  topic_id int(10) NOT NULL,
  parent_topic_id int(10) NOT NULL DEFAULT '0',
  topic_name varchar(255) DEFAULT NULL,
  PRIMARY KEY (topic_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE smb_issues (
  issue_id int(20) NOT NULL AUTO_INCREMENT,
  user_id int(20) DEFAULT NULL,
  account_id int(20) DEFAULT NULL,
  business_id int(20) NOT NULL,
  contact_name varchar(255) DEFAULT NULL,
  phone_number varchar(20) DEFAULT NULL,
  email_address varchar(100) DEFAULT NULL,
  preferred_contact_method enum('email','phone') NOT NULL DEFAULT 'email',
  topic_id int(10) NOT NULL,
  comments text,
  resolution_disposition enum('open','closed') NOT NULL DEFAULT 'open',
  PRIMARY KEY (issue_id),
  KEY account_id_index (account_id),
  KEY business_id_index (business_id),
  KEY topic_id_index (topic_id),
  KEY fk_smb_contact_al_issues_tbl_users1 (user_id)
) ENGINE=MyISAM AUTO_INCREMENT=14194 DEFAULT CHARSET=utf8;

CREATE TABLE smb_promo_messages (
  message_id int(20) NOT NULL AUTO_INCREMENT,
  business_id int(20) NOT NULL,
  one_min_message varchar(255) NOT NULL,
  message_type enum('message','offer','jobs','third_party_offer') NOT NULL DEFAULT 'message',
  start_timestamp timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  end_timestamp timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  email_before_expires_flag tinyint(1) NOT NULL DEFAULT '0',
  email_sent_flag tinyint(1) NOT NULL DEFAULT '0',
  impression_count int(10) NOT NULL DEFAULT '0',
  click_thru_count int(10) NOT NULL DEFAULT '0',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  version tinyint(4) DEFAULT NULL,
  provider_id int(4) DEFAULT NULL,
  message_title varchar(255) DEFAULT NULL,
  offer_url varchar(255) DEFAULT NULL,
  message_terms varchar(500) DEFAULT NULL,
  data_source_id smallint(6) NOT NULL DEFAULT '0',
  city_id int(11) DEFAULT NULL,
  transaction_term_id smallint(6) DEFAULT NULL,
  deal_start_timestamp timestamp NULL DEFAULT NULL,
  deal_end_timestamp timestamp NULL DEFAULT NULL,
  image_file_path varchar(255) DEFAULT NULL,
  purchase_price decimal(10,2) DEFAULT NULL,
  retail_value decimal(10,2) DEFAULT NULL,
  max_quantity_per_person int(11) DEFAULT NULL,
  min_quantity_per_person int(11) DEFAULT NULL,
  max_quantity_provided int(11) DEFAULT NULL,
  quantity_purchased int(11) DEFAULT NULL,
  description varchar(2048) DEFAULT NULL,
  PRIMARY KEY (message_id),
  KEY business_id_index (business_id),
  KEY end_timestamp_index (end_timestamp),
  KEY start_end_time_message_type_idx (start_timestamp,end_timestamp,message_type),
  KEY end_start_time_biz_id_message_type_idx (end_timestamp,start_timestamp,business_id,message_type),
  KEY business_start_end_time_message_type_idx (business_id,message_type,start_timestamp,end_timestamp)
) ENGINE=MyISAM AUTO_INCREMENT=216413 DEFAULT CHARSET=utf8;

CREATE TABLE smb_promo_messages_copy_do_not_delete (
  message_id int(20) NOT NULL AUTO_INCREMENT,
  business_id int(20) NOT NULL,
  one_min_message varchar(125) NOT NULL,
  message_type enum('message','offer','jobs') NOT NULL DEFAULT 'message',
  start_timestamp timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  end_timestamp timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  archive_flag tinyint(1) NOT NULL DEFAULT '0',
  email_before_expires_flag tinyint(1) NOT NULL DEFAULT '0',
  email_sent_flag tinyint(1) NOT NULL DEFAULT '0',
  impression_count int(10) NOT NULL DEFAULT '0',
  click_thru_count int(10) NOT NULL DEFAULT '0',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  version tinyint(4) DEFAULT NULL,
  PRIMARY KEY (message_id),
  KEY business_id_index (business_id),
  KEY end_timestamp_index (end_timestamp)
) ENGINE=MyISAM AUTO_INCREMENT=100581 DEFAULT CHARSET=utf8;

CREATE TABLE smb_promo_messages_history (
  history_id int(20) NOT NULL AUTO_INCREMENT,
  history_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  history_reason enum('deleted','updated') NOT NULL DEFAULT 'updated',
  message_id int(20) NOT NULL,
  business_id int(20) NOT NULL,
  one_min_message varchar(255) NOT NULL,
  message_type enum('message','offer','jobs','third_party_offer') NOT NULL DEFAULT 'message',
  start_timestamp timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  end_timestamp timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  version tinyint(4) DEFAULT '1',
  provider_id int(4) DEFAULT NULL,
  message_title varchar(255) DEFAULT NULL,
  offer_url varchar(255) DEFAULT NULL,
  message_terms varchar(500) DEFAULT NULL,
  data_source_id smallint(6) DEFAULT NULL,
  city_id int(11) DEFAULT NULL,
  transaction_term_id smallint(6) DEFAULT NULL,
  deal_start_timestamp timestamp NULL DEFAULT NULL,
  deal_end_timestamp timestamp NULL DEFAULT NULL,
  image_file_path varchar(255) DEFAULT NULL,
  purchase_price decimal(10,2) DEFAULT NULL,
  retail_value decimal(10,2) DEFAULT NULL,
  max_quantity_per_person int(11) DEFAULT NULL,
  min_quantity_per_person int(11) DEFAULT NULL,
  max_quantity_provided int(11) DEFAULT NULL,
  quantity_purchased int(11) DEFAULT NULL,
  description varchar(2048) DEFAULT NULL,
  PRIMARY KEY (history_id),
  KEY message_id_index (message_id),
  KEY business_id_index (business_id)
) ENGINE=MyISAM AUTO_INCREMENT=4178870 DEFAULT CHARSET=utf8;

CREATE TABLE smb_promo_sites (
  promo_site_id int(20) NOT NULL AUTO_INCREMENT,
  business_id int(20) NOT NULL,
  slogan varchar(120) DEFAULT NULL,
  business_summary varchar(240) DEFAULT NULL,
  what_makes_us_different varchar(240) DEFAULT NULL,
  pm_amex_accepted_flag tinyint(1) NOT NULL DEFAULT '0',
  pm_cash_accepted_flag tinyint(1) NOT NULL DEFAULT '0',
  pm_check_accepted_flag tinyint(1) NOT NULL DEFAULT '0',
  pm_moneyorder_accepted_flag tinyint(1) NOT NULL DEFAULT '0',
  pm_paypal_accepted_flag tinyint(1) NOT NULL DEFAULT '0',
  pm_debitcard_accepted_flag tinyint(1) NOT NULL DEFAULT '0',
  pm_bankwire_accepted_flag tinyint(1) NOT NULL DEFAULT '0',
  pm_visa_accepted_flag tinyint(1) NOT NULL DEFAULT '0',
  pm_mastercard_accepted_flag tinyint(1) NOT NULL DEFAULT '0',
  pm_discover_accepted_flag tinyint(1) NOT NULL DEFAULT '0',
  license_number varchar(120) DEFAULT NULL,
  hide_license_flag tinyint(1) NOT NULL DEFAULT '0',
  cust_comment1_user_id int(20) DEFAULT NULL,
  cust_comment2_user_id int(20) DEFAULT NULL,
  cust_comment3_user_id int(20) DEFAULT NULL,
  logo_image_file_path varchar(150) DEFAULT NULL,
  photo_image_file_path varchar(150) DEFAULT NULL,
  PRIMARY KEY (promo_site_id),
  KEY business_id_index (business_id),
  KEY cust_comment1_user_id_index (cust_comment1_user_id),
  KEY cust_comment2_user_id_index (cust_comment2_user_id),
  KEY cust_comment3_user_id_index (cust_comment3_user_id)
) ENGINE=MyISAM AUTO_INCREMENT=105933 DEFAULT CHARSET=utf8;

CREATE TABLE snp_attributes_foursquare (
  snp_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  checkin_threshold smallint(6) NOT NULL DEFAULT '0',
  convert_mayorship_flag tinyint(1) NOT NULL DEFAULT '0',
  twitter_user_name varchar(100) DEFAULT NULL,
  facebook_user_id varchar(45) DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (snp_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE social_network_attributes (
  sn_id tinyint(4) NOT NULL,
  sn_user_id bigint(20) unsigned NOT NULL,
  the_key varchar(255) DEFAULT NULL,
  the_value varchar(255) DEFAULT NULL,
  KEY sn_id_sn_user_id_index (sn_id,sn_user_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE social_network_profiles (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  sn_id tinyint(4) NOT NULL,
  sn_user_id varchar(50) CHARACTER SET latin1 NOT NULL,
  user_id int(20) NOT NULL,
  full_name varchar(255) DEFAULT NULL,
  email varchar(255) DEFAULT NULL,
  sn_profile_update_utc bigint(20) NOT NULL DEFAULT '0',
  sn_user_details_md5 varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  email_confirmed_flag tinyint(1) NOT NULL DEFAULT '0',
  import_from_sn_flag tinyint(1) NOT NULL,
  email_verification_code varchar(150) CHARACTER SET latin1 DEFAULT NULL,
  email_verification_timestamp timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  user_name varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  authentication_token varchar(255) DEFAULT NULL,
  access_token varchar(255) DEFAULT NULL,
  access_token_secret varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY sn_id_sn_user_id_index (sn_id,sn_user_id),
  KEY sn_id_index (sn_id),
  KEY email_index (email),
  KEY sn_user_id_index (sn_user_id),
  KEY user_id_index (user_id),
  KEY email_verification_code (email_verification_code) USING BTREE,
  KEY sn_id_email (sn_id,email)
) ENGINE=InnoDB AUTO_INCREMENT=33899 DEFAULT CHARSET=utf8;

CREATE TABLE social_networks (
  id tinyint(3) unsigned NOT NULL,
  sn_id tinyint(3) unsigned NOT NULL,
  sn_name varchar(64) CHARACTER SET utf8 NOT NULL,
  created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY sn_id_index (sn_id),
  UNIQUE KEY sn_name_index (sn_name)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE staging_marketing_test_businesses (
  business_type_name varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  business_name varchar(255) CHARACTER SET utf8 NOT NULL,
  business_id int(20) NOT NULL DEFAULT '0',
  address1 varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  city_name varchar(255) CHARACTER SET utf8 NOT NULL,
  state_code varchar(2) CHARACTER SET utf8 NOT NULL,
  zip_code varchar(10) CHARACTER SET utf8 DEFAULT '0',
  like_count decimal(23,0) DEFAULT NULL,
  rand double(17,0) DEFAULT NULL,
  id int(11) NOT NULL AUTO_INCREMENT,
  activation_code1 char(5) DEFAULT NULL,
  delivery_method1 varchar(10) DEFAULT NULL,
  delivery_date1 datetime DEFAULT NULL,
  activation_code2 char(5) DEFAULT NULL,
  delivery_method2 varchar(10) DEFAULT NULL,
  delivery_date2 datetime DEFAULT NULL,
  note varchar(2048) DEFAULT NULL,
  var1 varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  var2 varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  var3 varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  var4 varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  var5 varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=10150 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_account_updates (
  id int(20) NOT NULL AUTO_INCREMENT,
  user_id int(20) NOT NULL,
  login_name varchar(100) DEFAULT NULL,
  first_name varchar(100) DEFAULT NULL,
  last_name varchar(100) DEFAULT NULL,
  modified_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  code char(1) NOT NULL,
  is_indexed char(1) NOT NULL DEFAULT 'n',
  PRIMARY KEY (id),
  KEY is_indexed_index (is_indexed),
  KEY modified_on_index (modified_on)
) ENGINE=MyISAM AUTO_INCREMENT=32855 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_activity_log (
  id int(20) NOT NULL AUTO_INCREMENT,
  activity_id int(20) NOT NULL,
  user_id int(20) NOT NULL,
  resource_id int(20) NOT NULL,
  action_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY user_id_index (user_id),
  KEY activity_id_index (activity_id),
  KEY user_id_activity_id_resource_id_index (user_id,activity_id,resource_id)
) ENGINE=MyISAM AUTO_INCREMENT=166277 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_alikelist_stats (
  cities_covered int(11) NOT NULL,
  total_businesses int(11) NOT NULL,
  total_business_types int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE tbl_analytics_search_history (
  search_dt timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  search_type enum('l1','l2','l3','l4','l5','name','text') DEFAULT NULL,
  business_id int(20) DEFAULT NULL,
  category_id int(20) DEFAULT NULL,
  city_id int(20) NOT NULL,
  user_id int(20) DEFAULT NULL,
  session_id varchar(255) DEFAULT NULL,
  client_ip varchar(255) DEFAULT NULL,
  browser_info varchar(255) DEFAULT NULL,
  page_url varchar(255) DEFAULT NULL,
  text_normalized varchar(255) NOT NULL,
  location_normalized varchar(255) NOT NULL,
  latitude double DEFAULT NULL,
  longitude double DEFAULT NULL,
  radius int(5) DEFAULT NULL,
  results_count int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_ask_requests (
  ask_request_id int(20) NOT NULL AUTO_INCREMENT,
  ask_request_gpid int(11) NOT NULL DEFAULT '0',
  ask_request_from int(20) NOT NULL,
  ask_request_to int(20) NOT NULL,
  ask_request_to_email_id varchar(255) NOT NULL,
  to_first_name varchar(255) DEFAULT NULL,
  to_last_name varchar(255) NOT NULL,
  ask_search_for varchar(250) NOT NULL,
  city_id int(20) NOT NULL,
  state_code varchar(2) NOT NULL,
  ask_request_sent_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ask_request_status enum('read','unread','pending','declined','replied') DEFAULT 'pending',
  ask_request_type enum('multiple','emailList','asklist','addressBook') DEFAULT 'multiple',
  action_time timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  ask_request_message text NOT NULL,
  inbox_status enum('read','unread','deleted','sent_deleted') NOT NULL DEFAULT 'unread',
  response_flag enum('t','f') NOT NULL DEFAULT 'f',
  PRIMARY KEY (ask_request_id),
  KEY ask_request_to_index (ask_request_to),
  KEY ask_request_to_inbox_status_index (ask_request_to,inbox_status),
  KEY city_id_index (city_id)
) ENGINE=MyISAM AUTO_INCREMENT=4832 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_ask_response (
  ask_response_id int(20) NOT NULL AUTO_INCREMENT,
  ask_request_id int(11) NOT NULL,
  ask_request_gpid int(11) NOT NULL,
  ask_response_from int(20) NOT NULL,
  ask_response_to int(20) NOT NULL,
  to_first_name varchar(255) DEFAULT NULL,
  to_last_name varchar(255) NOT NULL,
  from_email varchar(100) NOT NULL,
  from_first_name varchar(255) NOT NULL,
  from_last_name varchar(255) NOT NULL,
  business_type_id int(20) NOT NULL,
  ask_response_sent_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ask_response_status enum('read','unread','pending','declined') DEFAULT 'pending',
  action_time timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  ask_response_message text NOT NULL,
  inbox_status enum('read','unread','deleted','sent_deleted') NOT NULL DEFAULT 'unread',
  PRIMARY KEY (ask_response_id),
  KEY ask_response_to_index (ask_response_to),
  KEY ask_response_to_inbox_status_index (ask_response_to,inbox_status),
  KEY ask_response_from_index (ask_response_from),
  KEY ask_request_id_index (ask_request_id),
  KEY business_type_id_index (business_type_id),
  KEY ask_response_status_index (ask_response_status)
) ENGINE=MyISAM AUTO_INCREMENT=2173 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_asklist_details (
  id bigint(11) NOT NULL AUTO_INCREMENT,
  ask_list_id int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  first_name varchar(128) DEFAULT NULL,
  last_name varchar(128) DEFAULT NULL,
  email_id varchar(128) DEFAULT NULL,
  delete_status char(1) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=381 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_asklist_master (
  ask_list_id int(11) NOT NULL AUTO_INCREMENT,
  ask_list_created_by int(11) DEFAULT NULL,
  ask_list_name varchar(100) DEFAULT NULL,
  ask_list_created_on datetime DEFAULT '0000-00-00 00:00:00',
  ask_list_modified_on datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (ask_list_id),
  KEY ask_list_created_by_index (ask_list_created_by)
) ENGINE=MyISAM AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_batch_load_control (
  id int(11) NOT NULL AUTO_INCREMENT,
  provider_id int(4) NOT NULL,
  load_type enum('offer','business') NOT NULL,
  load_step varchar(20) NOT NULL,
  load_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  load_input_name varchar(255) NOT NULL,
  start_time timestamp NULL DEFAULT NULL,
  end_time timestamp NULL DEFAULT NULL,
  status varchar(20) DEFAULT NULL,
  notes varchar(1024) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY fk_tbl_batch_load_control_tbl_external_providers1 (provider_id)
) ENGINE=MyISAM AUTO_INCREMENT=406 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_beacons (
  beacon_id int(20) NOT NULL AUTO_INCREMENT,
  creator_id int(20) NOT NULL,
  creator_type enum('user','business') NOT NULL DEFAULT 'user',
  business_id int(20) NOT NULL,
  beacon_message varchar(255) DEFAULT NULL,
  media_path varchar(150) DEFAULT NULL,
  recipient_id int(20) DEFAULT NULL,
  recipient_type enum('user','group') NOT NULL DEFAULT 'user',
  recipient_email varchar(100) DEFAULT NULL,
  start_timestamp timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  end_timestamp timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  pickup_only_flag tinyint(1) NOT NULL DEFAULT '0',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  start_timestamp_uts int(10) unsigned NOT NULL,
  end_timestamp_uts int(10) unsigned NOT NULL,
  PRIMARY KEY (beacon_id),
  KEY creator_id_index (creator_id),
  KEY business_id_index (business_id),
  KEY recipient_id_index (recipient_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_biz_to_biz_types (
  business_id int(20) NOT NULL,
  business_type_id int(20) NOT NULL,
  is_primary char(1) NOT NULL,
  business_type_path_seq varchar(255) NOT NULL,
  level1 int(11) DEFAULT NULL,
  businessid_level1_Key bigint(20) DEFAULT NULL,
  level2 int(11) DEFAULT NULL,
  level3 int(11) DEFAULT NULL,
  PRIMARY KEY (business_id,business_type_id),
  KEY business_id_index (business_id),
  KEY business_type_id_index (business_type_id),
  KEY level1_index (level1),
  KEY level2_index (level2),
  KEY level3_index (level3)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_business_rating (
  id int(11) NOT NULL AUTO_INCREMENT,
  businesses_id int(20) NOT NULL,
  user_list_id int(20) NOT NULL,
  note_text text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  list_type enum('mylist','watchlist') NOT NULL,
  rated_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  is_deleted enum('Y','N') NOT NULL DEFAULT 'N',
  city_id int(20) NOT NULL,
  rated_on_uts bigint(20) NOT NULL,
  data_source_id smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  UNIQUE KEY Business_UserId_Index (businesses_id,user_list_id),
  KEY businesses_id_index (businesses_id),
  KEY is_deleted_index (is_deleted),
  KEY user_list_id_index (user_list_id),
  KEY user_list_id_list_type_is_deleted_index (user_list_id,list_type,is_deleted),
  KEY rated_on_idx (rated_on),
  KEY is_deleted_list_type_index (is_deleted,list_type),
  KEY is_deleted_list_type_user_list_id_index (is_deleted,list_type,user_list_id),
  KEY businesses_id_is_deleted_index (businesses_id,is_deleted),
  KEY rated_on_uts_index (rated_on_uts),
  KEY city_id_index (city_id)
) ENGINE=InnoDB AUTO_INCREMENT=80763 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_business_rating_backup (
  id int(11) NOT NULL AUTO_INCREMENT,
  businesses_id int(20) NOT NULL,
  user_list_id int(20) NOT NULL,
  note_text text NOT NULL,
  list_type enum('mylist','watchlist') NOT NULL,
  rated_on timestamp NULL DEFAULT NULL,
  is_deleted enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (id),
  UNIQUE KEY Business_UserId_Index (businesses_id,user_list_id,list_type),
  KEY businesses_id_index (businesses_id),
  KEY is_deleted_index (is_deleted),
  KEY user_list_id_index (user_list_id),
  KEY user_list_id_list_type_is_deleted_index (user_list_id,list_type,is_deleted),
  KEY rated_on_idx (rated_on),
  KEY is_deleted_list_type_index (is_deleted,list_type),
  KEY is_deleted_list_type_user_list_id_index (is_deleted,list_type,user_list_id),
  KEY businesses_id_is_deleted_index (businesses_id,is_deleted)
) ENGINE=MyISAM AUTO_INCREMENT=46513 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_business_rating_history (
  history_id int(20) NOT NULL AUTO_INCREMENT,
  history_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  history_reason enum('deleted','merged','updated') NOT NULL DEFAULT 'updated',
  id int(11) NOT NULL,
  businesses_id int(20) NOT NULL,
  user_list_id int(20) NOT NULL,
  note_text text NOT NULL,
  list_type enum('mylist','watchlist') NOT NULL,
  rated_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  is_deleted enum('Y','N') NOT NULL DEFAULT 'N',
  merge_to_business_id int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (history_id),
  UNIQUE KEY Business_UserId_Index (businesses_id,user_list_id,list_type),
  KEY businesses_id_index (businesses_id),
  KEY is_deleted_index (is_deleted),
  KEY is_deleted_list_type_user_list_id_index (is_deleted,list_type,user_list_id)
) ENGINE=MyISAM AUTO_INCREMENT=1082 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_business_rating_new (
  id int(11) NOT NULL AUTO_INCREMENT,
  businesses_id int(20) NOT NULL,
  user_list_id int(20) NOT NULL,
  note_text text NOT NULL,
  list_type enum('mylist','watchlist') NOT NULL,
  rated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_deleted enum('Y','N') NOT NULL DEFAULT 'N',
  city_id int(20) NOT NULL,
  rated_on_uts int(10) unsigned NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY Business_UserId_Index (businesses_id,user_list_id,list_type),
  KEY businesses_id_index (businesses_id),
  KEY is_deleted_index (is_deleted),
  KEY user_list_id_index (user_list_id),
  KEY user_list_id_list_type_is_deleted_index (user_list_id,list_type,is_deleted),
  KEY rated_on_idx (rated_on),
  KEY is_deleted_list_type_index (is_deleted,list_type),
  KEY is_deleted_list_type_user_list_id_index (is_deleted,list_type,user_list_id),
  KEY businesses_id_is_deleted_index (businesses_id,is_deleted),
  KEY city_id_index (city_id),
  KEY city_id_rated_on_is_deleted_index (city_id,rated_on,is_deleted),
  KEY rated_on_uts_index (rated_on_uts)
) ENGINE=MyISAM AUTO_INCREMENT=40123 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_business_rating_wrk (
  id int(11) NOT NULL AUTO_INCREMENT,
  businesses_id int(20) NOT NULL,
  user_list_id int(20) NOT NULL,
  note_text text NOT NULL,
  list_type enum('mylist','watchlist') NOT NULL,
  rated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_deleted enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (id),
  UNIQUE KEY Business_UserId_Index (businesses_id,user_list_id,list_type),
  KEY businesses_id_index (businesses_id),
  KEY is_deleted_index (is_deleted),
  KEY user_list_id_index (user_list_id),
  KEY user_list_id_list_type_is_deleted_index (user_list_id,list_type,is_deleted),
  KEY rated_on_idx (rated_on),
  KEY is_deleted_list_type_index (is_deleted,list_type),
  KEY is_deleted_list_type_user_list_id_index (is_deleted,list_type,user_list_id),
  KEY businesses_id_is_deleted_index (businesses_id,is_deleted)
) ENGINE=MyISAM AUTO_INCREMENT=43941 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_business_types (
  business_type_id int(20) NOT NULL,
  business_type_name varchar(100) DEFAULT NULL,
  parent_business_type_id int(20) NOT NULL DEFAULT '0',
  business_type_path text,
  business_type_path2 varchar(255) DEFAULT NULL,
  business_type_path_seq varchar(255) DEFAULT NULL,
  category_id int(20) NOT NULL DEFAULT '0',
  is_leaf char(1) DEFAULT NULL,
  is_visible char(1) DEFAULT '1',
  al_golden_node_id int(11) DEFAULT '0',
  level_id int(2) DEFAULT '0',
  url_business_type varchar(255) NOT NULL,
  PRIMARY KEY (business_type_id),
  KEY parent_id_index (parent_business_type_id),
  KEY al_golden_node_idx (al_golden_node_id),
  KEY is_leaf_idx (is_leaf),
  KEY syph_id_index (category_id),
  KEY leve_id_idx (level_id),
  KEY url_business_type_idx (url_business_type),
  KEY business_type_name_index (business_type_name)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_business_types_al (
  business_type_id int(20) NOT NULL,
  business_type_name text,
  parent_business_type_id int(20) NOT NULL DEFAULT '0',
  business_type_path text,
  business_type_path2 varchar(255) DEFAULT NULL,
  syph_id int(20) NOT NULL DEFAULT '0',
  is_leaf char(1) DEFAULT NULL,
  is_visible char(1) DEFAULT '1',
  wand_node_id int(11) DEFAULT '0',
  level_id int(2) DEFAULT '0',
  PRIMARY KEY (business_type_id),
  KEY parent_id_index (parent_business_type_id),
  KEY syph_id_index (syph_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_business_types_bkup (
  business_type_id int(20) NOT NULL,
  business_type_name text,
  parent_business_type_id int(20) NOT NULL DEFAULT '0',
  business_type_path text,
  business_type_path2 varchar(255) DEFAULT NULL,
  business_type_path_seq varchar(255) DEFAULT NULL,
  syph_id int(20) NOT NULL DEFAULT '0',
  is_leaf char(1) DEFAULT NULL,
  is_visible char(1) DEFAULT '1',
  al_golden_node_id int(11) DEFAULT '0',
  level_id int(2) DEFAULT '0',
  PRIMARY KEY (business_type_id),
  KEY parent_id_index (parent_business_type_id),
  KEY al_golden_node_idx (al_golden_node_id),
  KEY is_leaf_idx (is_leaf),
  KEY syph_id_index (syph_id),
  KEY leve_id_idx (level_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_businesses (
  business_id int(20) NOT NULL AUTO_INCREMENT,
  business_name varchar(255) NOT NULL,
  business_type_id int(20) NOT NULL DEFAULT '0',
  business_user_id bigint(20) NOT NULL DEFAULT '0',
  address1 varchar(255) DEFAULT NULL,
  address2 varchar(255) DEFAULT NULL,
  city_id int(20) NOT NULL DEFAULT '0',
  state_code varchar(2) DEFAULT NULL,
  zip_code varchar(10) DEFAULT '0',
  business_phone varchar(20) DEFAULT NULL,
  business_secondary_phone varchar(20) DEFAULT NULL,
  business_tertiary_phone varchar(20) DEFAULT NULL,
  website varchar(255) DEFAULT NULL,
  business_info varchar(255) DEFAULT NULL,
  latitude double DEFAULT '0',
  longitude double DEFAULT '0',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  is_deleted enum('Y','N') DEFAULT 'N',
  source enum('localeze','Acxiom','ugc','al','smb','external') NOT NULL DEFAULT 'al',
  city varchar(255) DEFAULT NULL,
  is_rated char(1) DEFAULT 'N',
  source_external_id varchar(50) NOT NULL DEFAULT '0',
  reindex char(1) DEFAULT 'N',
  version tinyint(4) DEFAULT NULL,
  category_id int(20) DEFAULT NULL,
  business_entity_id int(20) DEFAULT NULL,
  claimed_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  email_display_name varchar(100) DEFAULT NULL,
  hide_address_flag tinyint(1) NOT NULL DEFAULT '0',
  al_provisioning_status enum('pending','active','cancel pending','inactive','expired','failed','grandfathered') NOT NULL DEFAULT 'inactive',
  default_image_file_path varchar(150) DEFAULT NULL,
  keywords text,
  parent_business_id int(20) DEFAULT NULL,
  PRIMARY KEY (business_id),
  KEY city_id_index (city_id),
  KEY latitude_index (latitude),
  KEY longitude_index (longitude),
  KEY state_code_index (state_code),
  KEY zip_code_index (zip_code),
  KEY source_external_index (source_external_id),
  KEY business_phone_index (business_phone),
  KEY reindex_idx (reindex),
  KEY business_type_id_index (business_type_id),
  KEY category_id_index (category_id),
  KEY business_entity_id_index (business_entity_id),
  KEY business_name_index (business_name),
  KEY al_provisioning_status_index (al_provisioning_status),
  KEY addr_index (address1),
  KEY state_code_business_name_idx (state_code,business_name)
) ENGINE=MyISAM AUTO_INCREMENT=13823587 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_businesses_history (
  history_id int(20) NOT NULL AUTO_INCREMENT,
  history_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  history_reason enum('deleted','merged','updated') NOT NULL DEFAULT 'updated',
  business_id int(20) NOT NULL,
  business_name varchar(255) NOT NULL,
  business_type_id int(20) NOT NULL,
  business_user_id bigint(20) NOT NULL,
  address1 varchar(255) DEFAULT NULL,
  address2 varchar(255) DEFAULT NULL,
  city_id int(20) NOT NULL,
  state_code varchar(2) DEFAULT NULL,
  zip_code varchar(10) DEFAULT NULL,
  business_phone varchar(20) DEFAULT NULL,
  business_secondary_phone varchar(20) DEFAULT NULL,
  business_tertiary_phone varchar(20) DEFAULT NULL,
  website varchar(255) DEFAULT NULL,
  business_info varchar(255) DEFAULT NULL,
  latitude double DEFAULT NULL,
  longitude double DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  is_deleted enum('Y','N') DEFAULT NULL,
  source enum('localeze','Acxiom','ugc','smb','al') NOT NULL,
  city varchar(255) DEFAULT NULL,
  is_rated char(1) DEFAULT NULL,
  source_external_id varchar(50) NOT NULL,
  reindex char(1) DEFAULT NULL,
  version tinyint(4) DEFAULT NULL,
  category_id int(20) DEFAULT NULL,
  business_entity_id int(20) DEFAULT NULL,
  claimed_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  email_display_name varchar(100) DEFAULT NULL,
  hide_address_flag tinyint(1) NOT NULL DEFAULT '0',
  al_provisioning_status enum('pending','active','cancel pending','inactive','expired','failed','grandfathered') NOT NULL DEFAULT 'inactive',
  default_image_file_path varchar(150) DEFAULT NULL,
  keywords text,
  parent_business_id int(20) DEFAULT NULL,
  merge_to_business_id int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (history_id),
  KEY business_id_index (business_id),
  KEY source_external_index (source_external_id)
) ENGINE=MyISAM AUTO_INCREMENT=34867840 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_cities (
  city_id int(20) NOT NULL,
  county_id int(20) NOT NULL,
  city_name varchar(255) NOT NULL,
  state_code varchar(2) NOT NULL,
  Latitude double NOT NULL,
  Longitude double NOT NULL,
  population int(10) DEFAULT '0',
  city_id_name_variation1 int(20) DEFAULT NULL,
  city_name_variation1 varchar(255) DEFAULT NULL,
  city_id_name_variation2 int(20) DEFAULT NULL,
  city_name_variation2 varchar(255) DEFAULT NULL,
  city_id_name_variation3 int(20) DEFAULT NULL,
  city_name_variation3 varchar(255) DEFAULT NULL,
  city_id_name_variation4 int(20) DEFAULT NULL,
  city_name_variation4 varchar(255) DEFAULT NULL,
  c1 char(1) NOT NULL,
  c2 char(2) NOT NULL,
  c3 varchar(3) DEFAULT NULL,
  c4 varchar(4) DEFAULT NULL,
  c5 varchar(5) DEFAULT NULL,
  c6 varchar(6) DEFAULT NULL,
  c7 varchar(7) DEFAULT NULL,
  c8 varchar(8) DEFAULT NULL,
  c9 varchar(9) DEFAULT NULL,
  c10 varchar(10) DEFAULT NULL,
  c11 varchar(11) DEFAULT NULL,
  c12 varchar(12) DEFAULT NULL,
  PRIMARY KEY (city_id),
  KEY city_name (city_name),
  KEY state_code (state_code),
  KEY tbl_cities_county_constraint (county_id),
  KEY c1_index (c1),
  KEY c2_index (c2),
  KEY c3_index (c3),
  KEY c4_index (c4),
  KEY c5_index (c5),
  KEY c6_index (c6),
  KEY c7_index (c7),
  KEY c8_index (c8),
  KEY c9_index (c9),
  KEY c10_index (c10),
  KEY c11_index (c11),
  KEY c12_index (c12),
  KEY city_name_state_code_index (city_name,state_code)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_city_distance (
  city_id int(20) NOT NULL,
  radius tinyint(4) NOT NULL,
  distance float(5,2) NOT NULL,
  near_city_id int(20) NOT NULL,
  KEY city_id_radius_index (city_id,radius),
  KEY city_id_radius_near_city_id_index (city_id,radius,near_city_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_claimed_businesses_near_city (
  email_batch_id int(11) NOT NULL,
  city_id int(11) NOT NULL,
  total_claimed_businesses int(11) DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (email_batch_id,city_id),
  KEY fk_tbl_near_city_deals_tbl_email_batches1 (email_batch_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE tbl_comments (
  comment_id int(11) NOT NULL AUTO_INCREMENT,
  object_type_id smallint(6) DEFAULT NULL,
  object_id int(11) DEFAULT NULL,
  comments mediumtext,
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (comment_id)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_cron_timestamp (
  process_id int(11) NOT NULL AUTO_INCREMENT,
  cron_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  status enum('t','f') NOT NULL DEFAULT 'f',
  cron_type varchar(20) NOT NULL,
  PRIMARY KEY (process_id)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_data_source_object_types (
  data_source_id smallint(6) NOT NULL,
  object_type_id smallint(6) NOT NULL,
  created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (data_source_id,object_type_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_data_sources (
  data_source_id smallint(6) NOT NULL,
  data_source_name varchar(45) DEFAULT NULL,
  last_load_timestamp timestamp NULL DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (data_source_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_database_version (
  id int(11) NOT NULL AUTO_INCREMENT,
  version_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  release_version varchar(255) DEFAULT NULL,
  database_version varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_delete_merge_business_listings (
  id int(11) NOT NULL AUTO_INCREMENT,
  delete_business_id int(20) NOT NULL,
  merge_to_business_id int(20) DEFAULT NULL,
  action enum('delete','merge') NOT NULL,
  status_id int(11) NOT NULL,
  status_message text,
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_business_backup mediumblob,
  PRIMARY KEY (id),
  KEY delete_business_id (delete_business_id,merge_to_business_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tbl_delete_merge_business_listings_status (
  status_id tinyint(4) NOT NULL,
  status_id_description varchar(40) NOT NULL,
  PRIMARY KEY (status_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tbl_deleted_businesses (
  deleted_business_id int(20) NOT NULL,
  merge_to_business_id int(20) DEFAULT '0',
  is_deleted_from_memcached tinyint(1) DEFAULT '0',
  is_deleted_from_index tinyint(1) DEFAULT '0',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (deleted_business_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_deleted_users (
  id int(20) NOT NULL AUTO_INCREMENT,
  user_id int(20) NOT NULL,
  first_name varchar(100) NOT NULL,
  last_name varchar(100) NOT NULL,
  email varchar(255) DEFAULT NULL,
  deleted_by_user_id int(20) DEFAULT NULL,
  deleted_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  serialized_parameters mediumblob,
  PRIMARY KEY (id),
  UNIQUE KEY user_id_index (user_id)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_dma_cities (
  dma_code int(3) NOT NULL,
  dma_name varchar(255) NOT NULL,
  dma_rank int(3) NOT NULL,
  city_id int(20) NOT NULL,
  woeid int(20) NOT NULL,
  centroid_lat double NOT NULL,
  centroid_long double NOT NULL,
  radius int(5) NOT NULL,
  PRIMARY KEY (dma_code),
  UNIQUE KEY city_id_index (city_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_email_batches (
  email_batch_id int(11) NOT NULL AUTO_INCREMENT,
  batch_name varchar(255) DEFAULT NULL,
  campaign_name varchar(255) DEFAULT NULL,
  last_batch_timestamp timestamp NULL DEFAULT NULL,
  start_timestamp timestamp NULL DEFAULT NULL,
  end_timestamp timestamp NULL DEFAULT NULL,
  status varchar(45) DEFAULT NULL,
  notes text,
  PRIMARY KEY (email_batch_id)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_email_communications (
  email_communication_id int(20) NOT NULL AUTO_INCREMENT,
  source enum('promoreminders','invitations') NOT NULL DEFAULT 'invitations',
  from_user_id int(20) NOT NULL,
  to_email_address varchar(100) NOT NULL,
  from_name varchar(255) NOT NULL,
  from_email_address varchar(255) NOT NULL,
  reply_to_email_address varchar(255) NOT NULL,
  to_name varchar(255) NOT NULL,
  email_subject varchar(255) NOT NULL,
  email_content_html text NOT NULL,
  email_content_text text NOT NULL,
  status enum('queued','sent','failed') NOT NULL DEFAULT 'queued',
  retry_count tinyint(4) NOT NULL DEFAULT '0',
  create_timestamp timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  last_attempt_timestamp timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  sent_timestamp timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (email_communication_id),
  KEY from_user_id_index (from_user_id)
) ENGINE=MyISAM AUTO_INCREMENT=429 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_event_logging_codes (
  logging_event_id int(10) NOT NULL,
  logging_event_name varchar(100) NOT NULL,
  logging_event_code varchar(100) DEFAULT NULL,
  PRIMARY KEY (logging_event_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_external_businesses (
  external_business_id int(20) NOT NULL AUTO_INCREMENT,
  external_reference_id varchar(50) NOT NULL DEFAULT '0',
  business_id int(20) DEFAULT NULL,
  business_name varchar(255) NOT NULL,
  business_type varchar(255) NOT NULL,
  street varchar(255) DEFAULT NULL,
  city varchar(255) NOT NULL,
  state varchar(255) DEFAULT NULL,
  country varchar(255) DEFAULT NULL,
  zip_code varchar(10) DEFAULT '0',
  latitude double DEFAULT '0',
  longitude double DEFAULT '0',
  business_phone varchar(20) DEFAULT NULL,
  website varchar(255) DEFAULT NULL,
  external_business_source enum('facebook','bookmarklet','restaurant.com','moneymailer','boss','foursquare','ValPak') NOT NULL DEFAULT 'facebook',
  external_page_url varchar(255) DEFAULT NULL,
  image_url varchar(255) DEFAULT NULL,
  fan_count int(20) DEFAULT '0',
  not_a_business tinyint(4) NOT NULL DEFAULT '0',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  match_score decimal(5,2) DEFAULT NULL,
  match_status enum('not_processed','match','no_match','need_review','inserted') NOT NULL DEFAULT 'not_processed',
  reviewer_name varchar(255) DEFAULT NULL,
  reviewer_comments varchar(1024) DEFAULT NULL,
  imported_from_snp_id int(11) DEFAULT NULL,
  categorized_flag tinyint(1) NOT NULL DEFAULT '0',
  blocked_flag tinyint(1) NOT NULL DEFAULT '0',
  data_source_id smallint(6) NOT NULL DEFAULT '5',
  PRIMARY KEY (external_business_id),
  UNIQUE KEY data_source_id_external_reference_id_idx (data_source_id,external_reference_id),
  KEY external_business_source_match_status_idx (external_business_source,match_status),
  KEY business_id_idx (business_id),
  KEY data_source_id_match_status_idx (data_source_id,match_status)
) ENGINE=InnoDB AUTO_INCREMENT=101276 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_external_categories (
  id int(11) NOT NULL AUTO_INCREMENT,
  external_category varchar(100) NOT NULL,
  external_subcategory varchar(100) DEFAULT NULL,
  business_type_id int(20) NOT NULL,
  external_category_source enum('facebook','moneymailer','valpak','restaurant.com','foursquare') NOT NULL DEFAULT 'facebook',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  data_source_id smallint(6) NOT NULL DEFAULT '5',
  PRIMARY KEY (id),
  UNIQUE KEY udx_data_source_id_ext_category_business_type_id (data_source_id,external_category,external_subcategory,business_type_id),
  KEY business_type_id_index (business_type_id),
  KEY idx_created_on (created_on),
  KEY idx_modified_on (modified_on)
) ENGINE=MyISAM AUTO_INCREMENT=1701 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_external_likes (
  id int(11) NOT NULL AUTO_INCREMENT,
  external_reference_id varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '0',
  external_user_id varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '0',
  user_id int(20) DEFAULT NULL,
  comment text CHARACTER SET latin1,
  external_like_source enum('facebook','foursquare','bookmarklet') NOT NULL DEFAULT 'facebook',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  imported_from_snp_id int(11) DEFAULT NULL,
  unliked_flag tinyint(4) NOT NULL DEFAULT '0',
  data_source_id smallint(6) NOT NULL DEFAULT '5',
  PRIMARY KEY (id),
  UNIQUE KEY udx_ext_reference_ext_user_id_data_source (external_reference_id,external_user_id,data_source_id),
  KEY Reference_User_Index (external_reference_id,external_like_source),
  KEY user_id_index (user_id),
  KEY ext_user_id_user_id_external_source_idx (external_user_id,user_id,external_like_source),
  KEY external_user_id_index (external_user_id),
  KEY external_reference_id_index (external_reference_id),
  KEY created_on_user_id_source (created_on,user_id,external_like_source),
  KEY idx_created_on_user_id_data_source (created_on,user_id,data_source_id),
  KEY idx_ext_user_id_user_id_data_source (external_user_id,user_id,data_source_id),
  KEY idx_ext_reference_data_source (external_reference_id,data_source_id)
) ENGINE=InnoDB AUTO_INCREMENT=25064 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_external_offers (
  id int(20) NOT NULL AUTO_INCREMENT,
  load_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  provider_id int(4) NOT NULL,
  external_reference_id varchar(50) NOT NULL,
  business_name varchar(255) DEFAULT NULL,
  business_address varchar(255) DEFAULT NULL,
  business_city varchar(255) DEFAULT NULL,
  business_state varchar(2) DEFAULT NULL,
  business_zip varchar(10) DEFAULT NULL,
  business_phone varchar(20) DEFAULT NULL,
  offer_url varchar(255) DEFAULT NULL,
  offer_message varchar(255) DEFAULT NULL,
  offer_title varchar(255) DEFAULT NULL,
  data_source_id smallint(6) NOT NULL DEFAULT '5',
  PRIMARY KEY (id),
  KEY fk_tbl_external_offers_tbl_external_businesses1 (external_reference_id),
  KEY fk_tbl_external_offers_tbl_external_providers1 (provider_id),
  KEY data_source_idx (data_source_id)
) ENGINE=MyISAM AUTO_INCREMENT=6435954 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_external_offers_history (
  history_id int(20) NOT NULL AUTO_INCREMENT,
  history_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  history_reason enum('deleted','updated') NOT NULL DEFAULT 'deleted',
  id int(20) NOT NULL,
  load_timestamp timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  provider_id int(4) NOT NULL,
  external_reference_id varchar(50) NOT NULL,
  business_name varchar(255) DEFAULT NULL,
  business_address varchar(255) DEFAULT NULL,
  business_city varchar(255) DEFAULT NULL,
  business_state varchar(2) DEFAULT NULL,
  business_zip varchar(10) DEFAULT NULL,
  business_phone varchar(20) DEFAULT NULL,
  offer_url varchar(255) DEFAULT NULL,
  offer_message varchar(255) DEFAULT NULL,
  offer_title varchar(255) DEFAULT NULL,
  data_source_id smallint(6) NOT NULL DEFAULT '5',
  PRIMARY KEY (history_id),
  KEY fk_tbl_external_offers_history_tbl_external_businesses1 (external_reference_id),
  KEY fk_tbl_external_offers_history_tbl_external_providers1 (provider_id)
) ENGINE=MyISAM AUTO_INCREMENT=6570058 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_external_page_admins (
  id int(20) NOT NULL AUTO_INCREMENT,
  social_network_profile_id int(20) DEFAULT NULL,
  external_reference_id varchar(50) NOT NULL DEFAULT '0',
  external_page_url varchar(255) DEFAULT NULL,
  external_reference_target enum('facebook','foursquare','twitter') NOT NULL DEFAULT 'facebook',
  business_id int(20) DEFAULT NULL,
  sync_with_sn_flag tinyint(1) NOT NULL DEFAULT '0',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY business_id_target_idx (business_id,external_reference_target) USING BTREE,
  KEY social_network_profile_id_index (social_network_profile_id),
  KEY business_id_idx (business_id)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_external_providers (
  provider_id int(4) NOT NULL,
  provider_name varchar(255) NOT NULL,
  default_offer_title varchar(255) DEFAULT NULL,
  default_offer_text varchar(255) DEFAULT NULL,
  event_code varchar(45) DEFAULT NULL,
  last_load_timestamp timestamp NULL DEFAULT NULL,
  PRIMARY KEY (provider_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_external_user_activities (
  id int(11) NOT NULL AUTO_INCREMENT,
  external_reference_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  data_source_id smallint(6) NOT NULL,
  external_activity_id varchar(100) NOT NULL,
  activity_datetime timestamp NULL DEFAULT NULL,
  activity_timezone varchar(100) DEFAULT NULL,
  activity_comment text NOT NULL,
  created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY user_id_external_reference_id_data_source_id (user_id,external_reference_id,data_source_id)
) ENGINE=MyISAM AUTO_INCREMENT=6275 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_friend_list (
  friends_list_id int(20) NOT NULL AUTO_INCREMENT,
  from_user_id int(20) NOT NULL,
  to_user_id int(20) NOT NULL,
  added_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  friend_type enum('AlikeList','Facebook','Foursquare') NOT NULL DEFAULT 'AlikeList',
  deleted enum('Y','N') CHARACTER SET latin1 NOT NULL DEFAULT 'N',
  PRIMARY KEY (friends_list_id),
  KEY to_user_id (to_user_id),
  KEY from_user_id_index (from_user_id),
  KEY from_user_id_to_user_id_index (from_user_id,to_user_id),
  KEY from_user_id_to_user_id_deleted_index (from_user_id,to_user_id,deleted),
  KEY friend_type_index (friend_type)
) ENGINE=InnoDB AUTO_INCREMENT=65915 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_geo_dir_log (
  row_id int(11) NOT NULL AUTO_INCREMENT,
  log_file_date date NOT NULL,
  anonymous_hits_total int(11) NOT NULL,
  anonymous_hits_success int(11) NOT NULL,
  anonymous_hits_failure int(11) NOT NULL,
  PRIMARY KEY (row_id)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_gofavo_stats (
  statistic_id int(11) unsigned NOT NULL AUTO_INCREMENT,
  statistic_field enum('users','businesses','localBusinesses','personalRelevantBusiness','otherBusiness','member','friendOfFriends','otherMember') NOT NULL,
  statsitic_value bigint(20) NOT NULL,
  updated_on datetime NOT NULL,
  PRIMARY KEY (statistic_id),
  UNIQUE KEY statistic_id (statistic_id),
  UNIQUE KEY statistic_id_2 (statistic_id)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 PACK_KEYS=0;

CREATE TABLE tbl_invitations (
  invitation_id int(20) NOT NULL AUTO_INCREMENT,
  invitation_grp_id int(10) NOT NULL DEFAULT '0',
  invitation_from int(20) NOT NULL,
  invitation_to int(20) NOT NULL,
  to_email_id varchar(255) NOT NULL,
  to_first_name varchar(255) DEFAULT NULL,
  to_city_id int(20) NOT NULL,
  subject_id int(11) NOT NULL DEFAULT '0',
  subject varchar(255) NOT NULL,
  to_last_name varchar(255) NOT NULL,
  is_to_registered enum('y','n') NOT NULL DEFAULT 'n',
  invited_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  invitation_status enum('read','unread','accepted','pending','declined','bounced') DEFAULT 'pending',
  invitation_type enum('multiple','emailList','addressBook') DEFAULT NULL,
  action_time timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  invitation_message text NOT NULL,
  inbox_status enum('read','unread','deleted','sent_deleted') NOT NULL DEFAULT 'unread',
  from_first_name varchar(255) DEFAULT NULL,
  md5_invitation_id varchar(32) DEFAULT NULL,
  business_id int(20) DEFAULT NULL,
  is_sent_flag tinyint(1) NOT NULL DEFAULT '0',
  email_communication_id int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (invitation_id),
  KEY invitation_to_index (invitation_to),
  KEY invitation_to_inbox_status_index (invitation_to,inbox_status),
  KEY invitation_to_inbox_status_invitation_status_index (invitation_to,inbox_status,invitation_status),
  KEY md5_invitation_id_index (md5_invitation_id),
  KEY email_communication_id_index (email_communication_id),
  KEY invitation_from_index (invitation_from),
  KEY business_id_to_email_id_index (business_id,to_email_id)
) ENGINE=MyISAM AUTO_INCREMENT=26294 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_job_queue (
  id int(20) NOT NULL AUTO_INCREMENT,
  social_network_profile_id int(20) DEFAULT NULL,
  sn_id tinyint(4) NOT NULL DEFAULT '1',
  priority int(10) NOT NULL DEFAULT '0',
  job_status enum('pending','processing','completed','failed') NOT NULL DEFAULT 'pending',
  command enum('process_friends','process_businesses','process_likes','process_get_data','process_page_data','process_send_email','completed') NOT NULL DEFAULT 'process_get_data',
  session_secret varchar(200) DEFAULT NULL,
  serialized_parameters mediumblob,
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  retry_count smallint(6) DEFAULT '0',
  notes text,
  PRIMARY KEY (id),
  KEY social_network_profile_id_index (social_network_profile_id),
  KEY sn_id_index (sn_id)
) ENGINE=MyISAM AUTO_INCREMENT=408 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_lcd_flagged_business_listings (
  lcd_listing_flagged_id int(20) NOT NULL AUTO_INCREMENT,
  business_id int(20) NOT NULL,
  user_id int(20) NOT NULL,
  pushed_to_crm_flag tinyint(1) NOT NULL DEFAULT '0',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (lcd_listing_flagged_id),
  KEY business_id_index (business_id),
  KEY user_id_index (user_id),
  KEY pushed_to_crm_flag (pushed_to_crm_flag)
) ENGINE=MyISAM AUTO_INCREMENT=1324 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_list_items (
  user_id int(20) NOT NULL,
  list_id int(20) NOT NULL,
  item_id int(11) NOT NULL,
  PRIMARY KEY (user_id,list_id,item_id),
  KEY user_id_index (user_id),
  KEY list_id_index (list_id),
  KEY item_id_index (item_id),
  KEY user_id_item_id_index (user_id,item_id),
  KEY user_id_list_id_index (user_id,list_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_list_items_BETA (
  user_id int(20) NOT NULL,
  list_id int(20) NOT NULL,
  item_id int(11) NOT NULL,
  PRIMARY KEY (user_id,list_id,item_id),
  KEY user_id_index (user_id),
  KEY list_id_index (list_id),
  KEY item_id_index (item_id),
  KEY user_id_item_id_index (user_id,item_id),
  KEY user_id_list_id_index (user_id,list_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_list_items_BKUP (
  user_id int(20) NOT NULL,
  list_id int(20) NOT NULL,
  item_id int(11) NOT NULL,
  PRIMARY KEY (user_id,list_id,item_id),
  KEY user_id_index (user_id),
  KEY list_id_index (list_id),
  KEY item_id_index (item_id),
  KEY user_id_item_id_index (user_id,item_id),
  KEY user_id_list_id_index (user_id,list_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_list_items_history_to_be_deleted (
  history_id int(20) NOT NULL AUTO_INCREMENT,
  history_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  history_reason enum('deleted','merged','updated') NOT NULL DEFAULT 'updated',
  user_id int(20) NOT NULL,
  list_id int(20) NOT NULL,
  item_id int(11) NOT NULL,
  PRIMARY KEY (history_id),
  KEY user_id_index (user_id),
  KEY list_id_index (list_id),
  KEY item_id_index (item_id)
) ENGINE=MyISAM AUTO_INCREMENT=1007 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_list_items_to_be_deleted (
  user_id int(20) NOT NULL,
  list_id int(20) NOT NULL,
  item_id int(11) NOT NULL,
  PRIMARY KEY (user_id,list_id,item_id),
  KEY user_id_index (user_id),
  KEY list_id_index (list_id),
  KEY item_id_index (item_id),
  KEY user_id_item_id_index (user_id,item_id),
  KEY user_id_list_id_index (user_id,list_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_mail_share (
  message_id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT '0',
  business_name varchar(100) COLLATE latin1_general_ci NOT NULL,
  from_id int(11) DEFAULT NULL,
  from_name varchar(20) COLLATE latin1_general_ci NOT NULL,
  to_id int(11) DEFAULT NULL,
  to_name varchar(20) COLLATE latin1_general_ci NOT NULL,
  subject varchar(50) COLLATE latin1_general_ci NOT NULL,
  message text COLLATE latin1_general_ci,
  inbox_status enum('read','unread','deleted','sent_deleted') COLLATE latin1_general_ci NOT NULL DEFAULT 'unread',
  date_added datetime NOT NULL,
  PRIMARY KEY (message_id),
  KEY business_name (business_name,from_id,to_id),
  KEY to_id_index (to_id),
  KEY to_id_inbox_status_index (to_id,inbox_status)
) ENGINE=MyISAM AUTO_INCREMENT=5831 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

CREATE TABLE tbl_mailer_log (
  maillog_id bigint(20) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  logmessage text NOT NULL,
  email_header text NOT NULL,
  email_body text NOT NULL,
  mail_sent_on datetime NOT NULL,
  send_again_flag char(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (maillog_id)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_mailmsgs (
  message_id int(20) NOT NULL AUTO_INCREMENT,
  parent_id int(20) NOT NULL,
  thread_id int(20) NOT NULL,
  from_id int(20) NOT NULL,
  to_id int(20) NOT NULL,
  subject varchar(255) NOT NULL,
  message text NOT NULL,
  date_added timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  inbox_status enum('read','unread','deleted','sent_deleted') NOT NULL DEFAULT 'unread',
  message_type enum('ask','invite','message_expire_notice','inmail') NOT NULL DEFAULT 'ask',
  business_id int(20) DEFAULT NULL,
  PRIMARY KEY (message_id),
  KEY to_id_index (to_id),
  KEY to_id_inbox_status_index (to_id,inbox_status),
  KEY to_id_from_id_inbox_status_thread_id_index (to_id,from_id,inbox_status,thread_id),
  KEY from_id_index (from_id)
) ENGINE=MyISAM AUTO_INCREMENT=11293 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_object_types (
  object_type_id smallint(6) NOT NULL,
  object_type_name varchar(45) DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (object_type_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_periodicemail_city_deals (
  periodicemail_city_deals_id int(11) NOT NULL AUTO_INCREMENT,
  email_batch_id int(11) NOT NULL,
  user_city_id int(11) DEFAULT NULL,
  message_id int(11) NOT NULL,
  business_id int(11) NOT NULL,
  city_id int(11) DEFAULT NULL,
  city_name varchar(50) DEFAULT NULL,
  state_code varchar(2) DEFAULT NULL,
  business_name varchar(255) DEFAULT NULL,
  website varchar(255) DEFAULT NULL,
  message_type enum('offer','message','third_party_offer') DEFAULT NULL,
  provider_id int(11) DEFAULT NULL,
  offer_url varchar(255) DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  data_source_id smallint(6) DEFAULT NULL,
  PRIMARY KEY (periodicemail_city_deals_id),
  KEY idx_email_batch_id_user_city_id (email_batch_id,user_city_id) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=824120 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_periodicemail_claimed_businesses (
  periodicemail_claimed_businesses_id int(11) NOT NULL AUTO_INCREMENT,
  email_batch_id int(11) NOT NULL,
  city_id int(11) DEFAULT NULL,
  business_id int(11) DEFAULT NULL,
  business_name varchar(255) DEFAULT NULL,
  activation_date timestamp NULL DEFAULT NULL,
  image_file_path varchar(150) DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (periodicemail_claimed_businesses_id),
  KEY fk_tbl_periodicemail_claimed_businesses_tbl_email_batches1 (email_batch_id),
  KEY idx_email_batch_id_city_id (email_batch_id,city_id)
) ENGINE=InnoDB AUTO_INCREMENT=8318 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_periodicemail_execution_log (
  sp_name varchar(50) DEFAULT NULL,
  statement varchar(1024) DEFAULT NULL,
  execution_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tbl_periodicemail_friends_liked (
  periodicemail_friends_liked_id int(11) NOT NULL AUTO_INCREMENT,
  user_periodicemail_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  friend_user_id int(11) DEFAULT NULL,
  friend_first_name varchar(100) DEFAULT NULL,
  friend_last_name varchar(100) DEFAULT NULL,
  profile_photo_path varchar(150) DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (periodicemail_friends_liked_id),
  KEY fk_tbl_periodicemail_friends_liked_tbl_user_periodicemail1 (user_periodicemail_id)
) ENGINE=InnoDB AUTO_INCREMENT=25373 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_periodicemail_special_users (
  email_batch_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (email_batch_id,user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE tbl_periodicemail_user_status (
  user_id int(11) NOT NULL,
  noactivity_email_sent_flag tinyint(4) NOT NULL,
  status_email_batch_id int(11) NOT NULL,
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE tbl_possible_activities (
  id int(20) NOT NULL AUTO_INCREMENT,
  activity varchar(255) NOT NULL,
  show enum('Y','N') NOT NULL DEFAULT 'Y' COMMENT 'If Y then activity will be shown in front end, else will not be shown',
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_rpt_calendar (
  calendar_date date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE tbl_rpt_daily_kpi (
  calendar_date date NOT NULL,
  registered_users int(11) NOT NULL DEFAULT '0',
  claimed_bls int(11) NOT NULL DEFAULT '0',
  bls_with_messages_offers int(11) NOT NULL DEFAULT '0',
  bls_with_active_smb_offers int(11) NOT NULL DEFAULT '0',
  bls_with_active_3rd_party_offers int(11) NOT NULL DEFAULT '0',
  bls_with_comments int(11) NOT NULL DEFAULT '0',
  bls_received_new_comments int(11) NOT NULL DEFAULT '0',
  total_comments int(11) NOT NULL DEFAULT '0',
  likelist_likes int(11) NOT NULL DEFAULT '0',
  external_likes int(11) NOT NULL DEFAULT '0',
  off_fb_external_likes int(11) NOT NULL DEFAULT '0',
  total_likes int(11) NOT NULL DEFAULT '0',
  total_searches int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (calendar_date)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE tbl_rpt_execution_log (
  sp_name varchar(50) DEFAULT NULL,
  statement varchar(1024) DEFAULT NULL,
  execution_time datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE tbl_rpt_monthly_kpi (
  calendar_month varchar(20) NOT NULL,
  registered_users int(11) NOT NULL DEFAULT '0',
  claimed_bls int(11) NOT NULL DEFAULT '0',
  bls_with_messages_offers int(11) NOT NULL DEFAULT '0',
  bls_with_active_smb_offers int(11) NOT NULL DEFAULT '0',
  bls_with_active_3rd_party_offers int(11) NOT NULL DEFAULT '0',
  bls_with_comments int(11) NOT NULL DEFAULT '0',
  bls_received_new_comments int(11) NOT NULL DEFAULT '0',
  total_comments int(11) NOT NULL DEFAULT '0',
  likelist_likes int(11) NOT NULL DEFAULT '0',
  external_likes int(11) NOT NULL DEFAULT '0',
  off_fb_external_likes int(11) NOT NULL DEFAULT '0',
  total_likes int(11) NOT NULL DEFAULT '0',
  total_searches int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (calendar_month)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE tbl_rpt_staging_business_rating (
  id int(11) NOT NULL,
  businesses_id int(20) NOT NULL,
  user_list_id int(20) NOT NULL,
  has_comment_flag varchar(1) NOT NULL,
  list_type enum('mylist','watchlist') NOT NULL,
  rated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  is_deleted enum('Y','N') NOT NULL,
  city_id int(20) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE tbl_rpt_staging_promo_messages (
  message_id int(20) NOT NULL AUTO_INCREMENT,
  business_id int(20) NOT NULL,
  has_valid_message_flag varchar(1) NOT NULL,
  message_type enum('message','offer','jobs','third_party_offer') NOT NULL,
  start_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  end_timestamp timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  impression_count int(10) NOT NULL,
  click_thru_count int(10) NOT NULL,
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (message_id)
) ENGINE=MyISAM AUTO_INCREMENT=210301 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_rpt_zlikes_per_city (
  city varchar(255) DEFAULT NULL,
  state char(2) DEFAULT NULL,
  likes int(11) DEFAULT NULL,
  unique_likes int(11) DEFAULT NULL,
  registered_users int(11) DEFAULT NULL,
  stub_users int(11) DEFAULT NULL,
  claimed_bls int(11) DEFAULT NULL,
  claimed_BLs_with_Messages_Offers int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE tbl_search_query (
  search_id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  city_id int(11) NOT NULL,
  state_code varchar(2) NOT NULL,
  distance int(2) NOT NULL DEFAULT '0',
  filter_type varchar(255) NOT NULL,
  search_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  search_for varchar(250) NOT NULL,
  category_filter text NOT NULL,
  alpha_filter varchar(2) NOT NULL,
  city_filter text,
  friend_filter text NOT NULL,
  sort_order_by varchar(250) NOT NULL,
  search_tab varchar(10) NOT NULL,
  search_context enum('browse-category','home-page','search-header') NOT NULL DEFAULT 'search-header',
  PRIMARY KEY (search_id),
  KEY city_id (city_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE tbl_search_records (
  id int(10) NOT NULL AUTO_INCREMENT,
  search_id int(10) NOT NULL,
  resultset text,
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE tbl_state (
  state_id int(20) NOT NULL AUTO_INCREMENT,
  state_name varchar(128) NOT NULL,
  state_code varchar(2) NOT NULL,
  PRIMARY KEY (state_id)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_subject (
  subject_id int(11) NOT NULL AUTO_INCREMENT,
  subject varchar(255) NOT NULL,
  template text NOT NULL,
  PRIMARY KEY (subject_id)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_supressed_emails (
  supress_id int(20) NOT NULL AUTO_INCREMENT,
  email_address varchar(60) NOT NULL,
  created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (supress_id),
  KEY email_address_index (email_address)
) ENGINE=MyISAM AUTO_INCREMENT=268 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_ugc_businesses (
  business_id int(20) NOT NULL AUTO_INCREMENT,
  business_name varchar(255) NOT NULL,
  business_type_id int(20) NOT NULL DEFAULT '0',
  business_user_id bigint(20) NOT NULL DEFAULT '0',
  address1 varchar(255) DEFAULT NULL,
  address2 varchar(255) DEFAULT NULL,
  city_id int(20) NOT NULL DEFAULT '0',
  state_code varchar(2) DEFAULT NULL,
  zip_code varchar(10) DEFAULT '0',
  business_phone varchar(20) DEFAULT NULL,
  business_secondary_phone varchar(20) DEFAULT NULL,
  business_tertiary_phone varchar(20) DEFAULT NULL,
  website varchar(255) DEFAULT NULL,
  business_info varchar(255) DEFAULT NULL,
  latitude double DEFAULT '0',
  longitude double DEFAULT '0',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  is_deleted enum('Y','N') DEFAULT 'N',
  city varchar(255) DEFAULT NULL,
  is_rated char(1) DEFAULT 'N',
  source_external_id varchar(50) NOT NULL DEFAULT '0',
  user_entered_category varchar(255) DEFAULT NULL,
  PRIMARY KEY (business_id),
  KEY city_id_index (city_id),
  KEY latitude_index (latitude),
  KEY longitude_index (longitude),
  KEY state_code_index (state_code),
  KEY zip_code_index (zip_code),
  KEY business_phone_index (business_info),
  KEY source_external_index (source_external_id)
) ENGINE=MyISAM AUTO_INCREMENT=13808110 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_user_attributes (
  user_id int(20) NOT NULL,
  the_key tinyint(3) unsigned NOT NULL,
  the_value varchar(255) DEFAULT NULL,
  PRIMARY KEY (user_id,the_key),
  KEY user_id_index (user_id),
  KEY user_id_the_key_index (user_id,the_key)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_user_list_locations (
  user_list_location_id int(10) NOT NULL AUTO_INCREMENT,
  list_id int(20) NOT NULL,
  city_id int(20) NOT NULL,
  radius int(5) NOT NULL,
  PRIMARY KEY (user_list_location_id),
  KEY list_id_index (list_id),
  KEY city_id (city_id)
) ENGINE=MyISAM AUTO_INCREMENT=1008 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_user_lists (
  list_id int(20) NOT NULL AUTO_INCREMENT,
  user_id int(20) NOT NULL,
  list_name varchar(32) NOT NULL,
  list_notes varchar(255) DEFAULT NULL,
  is_shared char(1) NOT NULL DEFAULT 'N',
  privacy_state enum('private','public','friendsonly') NOT NULL DEFAULT 'friendsonly',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (list_id),
  UNIQUE KEY user_id_list_name_index (user_id,list_name),
  KEY user_id_index (user_id)
) ENGINE=MyISAM AUTO_INCREMENT=644 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_user_locations (
  user_id int(20) NOT NULL,
  city_id int(20) NOT NULL,
  radius int(5) NOT NULL,
  PRIMARY KEY (user_id,city_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE tbl_user_periodicemail (
  user_periodicemail_id int(11) NOT NULL AUTO_INCREMENT,
  email_batch_id int(11) NOT NULL,
  user_id int(20) NOT NULL,
  email varchar(255) DEFAULT NULL,
  first_name varchar(40) DEFAULT NULL,
  last_name varchar(40) DEFAULT NULL,
  city_id int(11) DEFAULT NULL,
  total_friends_liked_recently int(11) DEFAULT '0',
  total_businesses_liked_by_friends_recently int(11) DEFAULT '0',
  total_friends_liked int(11) DEFAULT '0',
  total_businesses_liked int(11) DEFAULT '0',
  total_businesses_activated_nearby_recently int(11) DEFAULT '0',
  total_deals_on_userlists int(11) DEFAULT '0',
  has_local_deals_flag tinyint(1) NOT NULL DEFAULT '0',
  city_name varchar(50) DEFAULT NULL,
  state_code varchar(2) DEFAULT NULL,
  status varchar(45) DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  serialized_parameters text,
  subbatch_thread_id tinyint(4) DEFAULT NULL,
  PRIMARY KEY (user_periodicemail_id),
  KEY fk_tbl_user_periodicemail_tbl_email_batches1 (email_batch_id),
  KEY fk_tbl_user_periodicemail_tbl_users1 (user_id),
  KEY idx_user_periodicemail_batch_user_city_id (email_batch_id,user_id,city_id),
  KEY idx_user_periodicemail_batch_status_city_id (email_batch_id,status,city_id),
  KEY idx_email_batch_city_id_has_local_deals_flag (email_batch_id,city_id,has_local_deals_flag),
  KEY idx_email_batch_id_has_local_deals_flag_city_id (email_batch_id,has_local_deals_flag,city_id)
) ENGINE=InnoDB AUTO_INCREMENT=97085 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_user_periodicemail_deals (
  user_periodicemail_deals_id int(11) NOT NULL AUTO_INCREMENT,
  user_periodicemail_id int(11) NOT NULL,
  message_id int(11) NOT NULL,
  user_id int(20) NOT NULL,
  email_batch_id int(11) DEFAULT NULL,
  business_id int(11) NOT NULL,
  deal_list_type enum('your_deals','local_deals') DEFAULT NULL,
  city_id int(11) DEFAULT NULL,
  city_name varchar(50) DEFAULT NULL,
  state_code varchar(2) DEFAULT NULL,
  business_name varchar(255) DEFAULT NULL,
  business_phone varchar(20) DEFAULT NULL,
  image_file_path varchar(150) DEFAULT NULL,
  website varchar(255) DEFAULT NULL,
  message_title varchar(255) DEFAULT NULL,
  one_min_message varchar(255) DEFAULT NULL,
  start_timestamp timestamp NULL DEFAULT NULL,
  end_timestamp timestamp NULL DEFAULT NULL,
  message_type enum('offer','message','third_party_offer') DEFAULT NULL,
  provider_id int(11) DEFAULT NULL,
  offer_url varchar(255) DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  data_source_id smallint(6) DEFAULT NULL,
  PRIMARY KEY (user_periodicemail_deals_id),
  KEY idx_user_periodicemail_message_id (user_periodicemail_id,message_id),
  KEY fk_tbl_user_periodicemail_deals_tbl_users1 (user_id) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5954 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_users (
  user_id int(20) NOT NULL AUTO_INCREMENT,
  password varchar(50) CHARACTER SET latin1 NOT NULL,
  user_level enum('admin','user') CHARACTER SET latin1 NOT NULL DEFAULT 'user',
  first_name varchar(100) NOT NULL,
  last_name varchar(100) NOT NULL,
  address1 varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  address2 varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  city_id int(20) NOT NULL,
  state char(2) CHARACTER SET latin1 DEFAULT NULL,
  zip_code varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_login_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  login_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  activation_code varchar(150) CHARACTER SET latin1 NOT NULL,
  profile_status enum('inactive','active','suspended','deleted','pending','facebook') CHARACTER SET latin1 NOT NULL DEFAULT 'inactive',
  user_info text CHARACTER SET latin1 NOT NULL,
  profile_photo_path varchar(255) CHARACTER SET latin1 NOT NULL,
  hobbies text CHARACTER SET latin1 NOT NULL,
  places text CHARACTER SET latin1 NOT NULL,
  things text CHARACTER SET latin1 NOT NULL,
  source enum('registration','ask','invite') CHARACTER SET latin1 NOT NULL DEFAULT 'registration',
  city_name varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  preferred_sn_id tinyint(3) NOT NULL DEFAULT '0',
  stub_flag tinyint(1) NOT NULL DEFAULT '0',
  data_source_id smallint(6) NOT NULL DEFAULT '0',
  preferences mediumtext,
  PRIMARY KEY (user_id),
  KEY login_name_profile_status_index (profile_status),
  KEY city_id_index (city_id),
  KEY created_on_stub_flag_idx (created_on,stub_flag),
  KEY first_name_idx (first_name),
  KEY last_name_idx (last_name)
) ENGINE=InnoDB AUTO_INCREMENT=32784 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_users_smb_notify (
  id int(20) NOT NULL AUTO_INCREMENT,
  business_id int(20) NOT NULL,
  ugc_business enum('Y','N') NOT NULL DEFAULT 'N',
  user_id int(20) NOT NULL DEFAULT '0',
  email_address varchar(100) NOT NULL,
  notify_me enum('Y','N') NOT NULL DEFAULT 'N',
  is_legal_owner enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (id),
  KEY business_id_index (business_id),
  KEY user_id_index (user_id)
) ENGINE=MyISAM AUTO_INCREMENT=135 DEFAULT CHARSET=latin1;

CREATE TABLE tbl_users_smb_notify_history (
  history_id int(20) NOT NULL AUTO_INCREMENT,
  history_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  history_reason enum('deleted','merged','updated') NOT NULL DEFAULT 'updated',
  id int(20) NOT NULL,
  business_id int(20) NOT NULL,
  ugc_business enum('Y','N') NOT NULL DEFAULT 'N',
  user_id int(20) NOT NULL DEFAULT '0',
  email_address varchar(100) NOT NULL,
  notify_me enum('Y','N') NOT NULL DEFAULT 'N',
  is_legal_owner enum('Y','N') NOT NULL DEFAULT 'N',
  merge_to_business_id int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (history_id),
  KEY business_id_index (business_id),
  KEY user_id_index (user_id)
) ENGINE=MyISAM AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

CREATE TABLE tbl_users_to_be_processed (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(20) NOT NULL,
  merged_to_user_id int(20) DEFAULT NULL,
  process_type enum('delete','merge') NOT NULL,
  process_start_timestamp timestamp NULL DEFAULT NULL,
  process_status varchar(20) NOT NULL DEFAULT 'not processed',
  last_step_name varchar(50) DEFAULT NULL,
  last_step_start_timestamp timestamp NULL DEFAULT NULL,
  last_step_end_timestamp timestamp NULL DEFAULT NULL,
  last_step_status varchar(50) DEFAULT 'started',
  notes varchar(1024) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tbl_view_business_log (
  view_id int(11) NOT NULL AUTO_INCREMENT,
  business_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  view_count int(11) NOT NULL,
  view_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (view_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE tbl_view_business_phone_log (
  view_id int(11) NOT NULL AUTO_INCREMENT,
  business_id int(11) NOT NULL,
  view_count int(11) NOT NULL,
  view_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (view_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE tbl_zip_code (
  zip_code varchar(5) COLLATE latin1_general_ci NOT NULL,
  city_name varchar(255) CHARACTER SET latin1 NOT NULL,
  city_id int(11) NOT NULL,
  state_code varchar(20) CHARACTER SET latin1 NOT NULL,
  latitude double NOT NULL,
  longitude double NOT NULL,
  country varchar(50) COLLATE latin1_general_ci NOT NULL,
  KEY latitude (latitude),
  KEY longitude (longitude),
  KEY city_id (city_id),
  KEY zip_code_index (zip_code),
  KEY state_code_index (state_code),
  KEY city_name_state_code_index (city_name,state_code)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

CREATE TABLE tmp_cities (
  city_id int(20) DEFAULT NULL,
  latitude double DEFAULT NULL,
  longitude double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE tmp_city_name_variation (
  city_id int(20) NOT NULL,
  city_id_name_variation int(20) NOT NULL,
  PRIMARY KEY (city_id),
  KEY city_id_name_variation (city_id_name_variation)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tmp_debug (
  str varchar(1000) DEFAULT NULL,
  ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE tmp_old_smb_accounts (
  account_id int(20) NOT NULL AUTO_INCREMENT,
  account_name varchar(255) NOT NULL,
  primary_user_id int(20) NOT NULL,
  secondary_user_id int(20) DEFAULT NULL,
  PRIMARY KEY (account_id),
  KEY fk_smb_accounts_tbl_users1 (secondary_user_id),
  KEY fk_smb_accounts_tbl_users2 (primary_user_id)
) ENGINE=MyISAM AUTO_INCREMENT=10350 DEFAULT CHARSET=utf8;

CREATE TABLE tmp_old_smb_business_entities (
  business_entity_id int(20) NOT NULL AUTO_INCREMENT,
  business_name varchar(255) NOT NULL,
  city_id int(20) NOT NULL DEFAULT '0',
  state_code varchar(2) DEFAULT NULL,
  account_id int(20) NOT NULL,
  address1 varchar(255) DEFAULT NULL,
  address2 varchar(255) DEFAULT NULL,
  primary_phone varchar(20) NOT NULL DEFAULT '0',
  zip_code varchar(10) DEFAULT NULL,
  current_provisioning_detail_id int(20) DEFAULT NULL,
  current_provisioning_source enum('aria') DEFAULT NULL,
  pro_subscription_thru timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  version tinyint(4) DEFAULT NULL,
  PRIMARY KEY (business_entity_id),
  KEY account_id_index (account_id)
) ENGINE=MyISAM AUTO_INCREMENT=100456 DEFAULT CHARSET=utf8;

CREATE TABLE tmp_rekey_accounts_wrk (
  new_account_id int(20) NOT NULL AUTO_INCREMENT,
  old_account_id int(20) NOT NULL,
  user_id int(20) NOT NULL,
  business_entity_id int(20) NOT NULL,
  business_name varchar(255) NOT NULL,
  PRIMARY KEY (new_account_id)
) ENGINE=MyISAM AUTO_INCREMENT=10386 DEFAULT CHARSET=utf8;

CREATE TABLE tmp_staging_import_SVVB (
  newbiz_ind char(1) DEFAULT NULL,
  business_name varchar(255) DEFAULT NULL,
  address1 varchar(255) DEFAULT NULL,
  city varchar(255) DEFAULT NULL,
  state_code varchar(2) DEFAULT NULL,
  zip_code varchar(10) DEFAULT NULL,
  business_phone varchar(20) DEFAULT NULL,
  website varchar(255) DEFAULT NULL,
  business_info varchar(255) DEFAULT NULL,
  category_name varchar(255) DEFAULT NULL,
  business_id varchar(20) DEFAULT NULL,
  business_type_id varchar(20) DEFAULT NULL,
  latitude double DEFAULT '0',
  longitude double DEFAULT '0',
  category_id varchar(20) DEFAULT NULL,
  city_id varchar(20) DEFAULT NULL,
  source_external_id varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE tr_del_ext_offers (
  id int(20) NOT NULL AUTO_INCREMENT,
  load_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  provider_id int(4) NOT NULL,
  external_reference_id varchar(50) NOT NULL,
  business_name varchar(255) DEFAULT NULL,
  business_address varchar(255) DEFAULT NULL,
  business_city varchar(255) DEFAULT NULL,
  business_state varchar(2) DEFAULT NULL,
  business_zip varchar(10) DEFAULT NULL,
  business_phone varchar(20) DEFAULT NULL,
  offer_url varchar(255) DEFAULT NULL,
  offer_message varchar(255) DEFAULT NULL,
  offer_title varchar(255) DEFAULT NULL,
  data_source_id smallint(6) NOT NULL DEFAULT '5',
  PRIMARY KEY (id),
  KEY fk_tbl_external_offers_tbl_external_businesses1 (external_reference_id) USING BTREE,
  KEY fk_tbl_external_offers_tbl_external_providers1 (provider_id) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4721003 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE transaction_terms (
  id smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  terms mediumtext,
  effective_start_date timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  effective_end_date timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  created_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE user_purchases (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  purchase_date timestamp NULL DEFAULT NULL,
  purchase_status enum('pending','paid','failed','refunded') NOT NULL,
  amount decimal(10,2) DEFAULT NULL,
  receipt mediumtext,
  created_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE user_stats_summary (
  user_id int(20) DEFAULT NULL,
  login_name varchar(100) DEFAULT NULL,
  first_name varchar(100) DEFAULT NULL,
  last_name varchar(100) DEFAULT NULL,
  email_id varchar(100) DEFAULT NULL,
  created_on timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  profile_status enum('inactive','active','suspended','deleted') DEFAULT NULL,
  source enum('registration','ask','invite') DEFAULT NULL,
  friends_count int(20) DEFAULT NULL,
  likelist_count int(20) DEFAULT NULL,
  last_modified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  invitation_count int(11) DEFAULT '0',
  UNIQUE KEY user_id_index (user_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE web_pages (
  id int(11) NOT NULL AUTO_INCREMENT,
  page_name varchar(50) NOT NULL,
  created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

INSERT INTO schema_migrations (version) VALUES ('20101027035503');

INSERT INTO schema_migrations (version) VALUES ('20101027041120');

INSERT INTO schema_migrations (version) VALUES ('20101027041419');

INSERT INTO schema_migrations (version) VALUES ('20101027045206');