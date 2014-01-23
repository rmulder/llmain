# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "abc", :force => true do |t|
    t.integer "b"
  end

  create_table "activities", :force => true do |t|
    t.string    "subject_type",        :limit => 20,                :null => false
    t.integer   "subject_id",                                       :null => false
    t.integer   "city_id"
    t.string    "activity_owner_type", :limit => 20,                :null => false
    t.string    "activity_group",      :limit => 20,                :null => false
    t.string    "activity_type",       :limit => 20,                :null => false
    t.timestamp "activity_date",                                    :null => false
    t.integer   "source_activity_id",                               :null => false
    t.timestamp "start_timestamp"
    t.timestamp "end_timestamp"
    t.integer   "user_id"
    t.timestamp "created_at",                                       :null => false
    t.timestamp "updated_at",                                       :null => false
    t.integer   "data_source_id",      :limit => 2,  :default => 0, :null => false
  end

  add_index "activities", ["activity_date", "id", "city_id", "activity_owner_type", "subject_id", "activity_group", "user_id", "activity_type"], :name => "idx_city_id_subject_type_subject_id"
  add_index "activities", ["activity_group", "activity_type", "start_timestamp", "end_timestamp"], :name => "idx_activity_group_type_start_end_time"
  add_index "activities", ["source_activity_id", "activity_type", "activity_group"], :name => "idx_source_activity_id_activity_type_activity_group"
  add_index "activities", ["subject_type", "subject_id", "activity_group", "start_timestamp", "end_timestamp"], :name => "idx_subject_type_subject_id_activity_type_start_exp_time"
  add_index "activities", ["user_id", "activity_owner_type", "city_id", "activity_date", "activity_type", "subject_type", "subject_id"], :name => "idx_user_id_subject_type_subject_id"

  create_table "batch_controller", :force => true do |t|
    t.string    "process",  :limit => 50
    t.timestamp "start_at",                                     :null => false
    t.timestamp "end_at",                                       :null => false
    t.string    "status",   :limit => 10, :default => "failed", :null => false
    t.string    "note",     :limit => 50, :default => "none",   :null => false
  end

  add_index "batch_controller", ["start_at", "process", "status"], :name => "start_at"

  create_table "business_source_categories", :force => true do |t|
    t.string    "category_name",    :limit => 150, :null => false
    t.string    "source",           :limit => 0,   :null => false
    t.integer   "source_id"
    t.integer   "business_type_id"
    t.timestamp "created_at",                      :null => false
    t.timestamp "updated_at",                      :null => false
  end

  add_index "business_source_categories", ["business_type_id"], :name => "fk_source_categories_business_types"
  add_index "business_source_categories", ["category_name"], :name => "category_name"
  add_index "business_source_categories", ["source_id", "source"], :name => "source_id_index"

  create_table "business_type_relations", :id => false, :force => true do |t|
    t.integer   "business_type_id",                                       :null => false
    t.integer   "parent_business_type_id",                 :default => 0, :null => false
    t.string    "business_type_name_path", :limit => 1023
    t.integer   "level_id",                                :default => 0
    t.integer   "level1_business_type_id"
    t.integer   "level2_business_type_id"
    t.integer   "level3_business_type_id"
    t.timestamp "created_at",                                             :null => false
    t.timestamp "updated_at",                                             :null => false
  end

  add_index "business_type_relations", ["business_type_id"], :name => "fk_relations_categories_business_types"

  create_table "business_types", :force => true do |t|
    t.string    "business_type_name",                :null => false
    t.integer   "wand_node_id",       :default => 0
    t.string    "url_business_type",                 :null => false
    t.timestamp "created_at",                        :null => false
    t.timestamp "updated_at",                        :null => false
  end

  create_table "business_types2", :force => true do |t|
    t.string    "business_type_name", :null => false
    t.integer   "wand_node_id",       :null => false
    t.string    "url_business_type"
    t.timestamp "created_at",         :null => false
    t.timestamp "updated_at",         :null => false
  end

  create_table "category_keywords", :primary_key => "keyword", :force => true do |t|
    t.integer "business_type_id", :null => false
    t.integer "level_id",         :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer   "list_entry_id",                                :null => false
    t.string    "comments",      :limit => 4096,                :null => false
    t.timestamp "created_at",                                   :null => false
    t.timestamp "updated_at",                                   :null => false
    t.integer   "iamhere_flag",  :limit => 1,    :default => 0, :null => false
    t.float     "tip_latitude"
    t.float     "tip_longitude"
  end

  add_index "comments", ["list_entry_id"], :name => "fk_comments_list_items"

  create_table "coupons", :force => true do |t|
    t.string    "coupon_unique_number", :limit => 10
    t.integer   "message_id",                                          :null => false
    t.integer   "business_id"
    t.integer   "user_purchase_id"
    t.timestamp "redeemed_date",                                       :null => false
    t.integer   "user_id"
    t.integer   "gift_flag",            :limit => 1,    :default => 0
    t.string    "first_name",           :limit => 45
    t.string    "last_name",            :limit => 45
    t.string    "email_address"
    t.string    "gift_text",            :limit => 4096
    t.timestamp "created_at",                                          :null => false
    t.timestamp "updated_at",                                          :null => false
  end

  add_index "coupons", ["business_id"], :name => "tbl_businesses_to_coupons"
  add_index "coupons", ["coupon_unique_number"], :name => "coupon_unique_number_UNIQUE", :unique => true
  add_index "coupons", ["user_purchase_id"], :name => "fk_tbl_coupons_tbl_user_deal_purchases1"

  create_table "db_error_log", :force => true do |t|
    t.string    "script_name", :limit => 50, :null => false
    t.timestamp "created_at",                :null => false
    t.string    "message"
    t.string    "reported",    :limit => 0,  :null => false
  end

  create_table "dbentry", :force => true do |t|
    t.string    "owner_type",     :limit => 0, :default => "User",     :null => false
    t.integer   "owner_id",                                            :null => false
    t.string    "type",           :limit => 0,                         :null => false
    t.string    "entry_type",     :limit => 0, :default => "Business", :null => false
    t.integer   "entry_id",                                            :null => false
    t.integer   "data_source_id", :limit => 2, :default => 0,          :null => false
    t.integer   "toplist_flag",   :limit => 1, :default => 0,          :null => false
    t.timestamp "created_at",                                          :null => false
    t.timestamp "updated_at",                                          :null => false
  end

  add_index "dbentry", ["entry_id", "entry_type"], :name => "idx_entry_id_entry_type"
  add_index "dbentry", ["owner_id", "owner_type", "entry_id", "entry_type"], :name => "udx_entry_id_entry_type", :unique => true
  add_index "dbentry", ["owner_type", "entry_type", "type", "toplist_flag", "updated_at"], :name => "idx_owner_type_type_date"

  create_table "dbiz", :id => false, :force => true do |t|
    t.integer "deleted_business_id"
  end

  create_table "dup_biz_status", :primary_key => "business_id", :force => true do |t|
    t.string  "factual_id", :limit => 36, :null => false
    t.string  "claimed",    :limit => 0,  :null => false
    t.integer "likes",                    :null => false
    t.integer "comments",                 :null => false
  end

  add_index "dup_biz_status", ["factual_id"], :name => "factual_id"

  create_table "external_categories", :force => true do |t|
    t.string    "external_category",    :limit => 100,                :null => false
    t.string    "external_subcategory", :limit => 100
    t.integer   "business_type_id",                                   :null => false
    t.integer   "data_source_id",       :limit => 2,   :default => 5, :null => false
    t.timestamp "created_at",                                         :null => false
    t.timestamp "updated_at",                                         :null => false
  end

  add_index "external_categories", ["business_type_id"], :name => "business_type_id_index"
  add_index "external_categories", ["data_source_id", "external_category", "external_subcategory", "business_type_id"], :name => "udx_data_source_id_ext_category_business_type_id", :unique => true

  create_table "external_categories2", :force => true do |t|
    t.string    "external_category",    :limit => 100,                :null => false
    t.string    "external_subcategory", :limit => 100
    t.integer   "business_type_id",                                   :null => false
    t.integer   "data_source_id",       :limit => 2,   :default => 5, :null => false
    t.timestamp "created_at",                                         :null => false
    t.timestamp "updated_at",                                         :null => false
  end

  add_index "external_categories2", ["business_type_id"], :name => "business_type_id_index"
  add_index "external_categories2", ["data_source_id", "external_category", "external_subcategory", "business_type_id"], :name => "udx_data_source_id_ext_category_business_type_id", :unique => true

  create_table "external_friends", :force => true do |t|
    t.integer   "from_user_id",                :null => false
    t.integer   "to_user_id"
    t.string    "sn_user_id",   :limit => 50,  :null => false
    t.integer   "sn_id",        :limit => 1,   :null => false
    t.string    "full_name"
    t.string    "email"
    t.string    "user_name",    :limit => 100
    t.string    "image_url"
    t.timestamp "created_at",                  :null => false
    t.timestamp "updated_at",                  :null => false
  end

  add_index "external_friends", ["from_user_id", "sn_user_id", "sn_id"], :name => "from_user_id", :unique => true
  add_index "external_friends", ["from_user_id"], :name => "fk_external_friends_users1"
  add_index "external_friends", ["sn_id"], :name => "fk_external_friends_social_networks1"
  add_index "external_friends", ["sn_user_id", "sn_id"], :name => "sn_user_sn_indx"
  add_index "external_friends", ["to_user_id"], :name => "fk_external_friends_users2"

  create_table "faqs", :force => true do |t|
    t.string  "subject"
    t.text    "text"
    t.string  "link"
    t.integer "display_order",              :default => 1
    t.string  "faq_type",      :limit => 0, :default => "smb"
  end

  create_table "faqs_web_pages", :force => true do |t|
    t.integer   "faq_id",      :null => false
    t.integer   "web_page_id", :null => false
    t.timestamp "created_at",  :null => false
  end

  add_index "faqs_web_pages", ["web_page_id"], :name => "fk_faqs_web_pages_web_page_id"

  create_table "hidden_gems", :force => true do |t|
    t.integer   "business_id",                                     :null => false
    t.string    "gem_description", :limit => 4096
    t.string    "image_file_path", :limit => 150
    t.integer   "city_id",                                         :null => false
    t.integer   "radius",          :limit => 2,    :default => 30, :null => false
    t.timestamp "valid_from",                                      :null => false
    t.timestamp "valid_to",                                        :null => false
    t.timestamp "created_at",                                      :null => false
    t.timestamp "updated_at",                                      :null => false
  end

  add_index "hidden_gems", ["business_id"], :name => "business_id_idx"

  create_table "images", :force => true do |t|
    t.string    "image_file_name",    :limit => 45, :null => false
    t.string    "image_content_type", :limit => 45
    t.integer   "image_file_size"
    t.timestamp "image_updated_at",                 :null => false
    t.string    "reference_type",     :limit => 0,  :null => false
    t.integer   "reference_id",                     :null => false
    t.timestamp "created_at",                       :null => false
  end

  create_table "invitations", :force => true do |t|
    t.integer   "user_id_from",                                                   :null => false
    t.integer   "user_id_to"
    t.string    "external_recipient_id"
    t.string    "invitation_type",        :limit => 0,  :default => "new_member", :null => false
    t.integer   "sn_id",                  :limit => 1,                            :null => false
    t.string    "facebook_request_id"
    t.string    "invitation_status",      :limit => 0,  :default => "pending"
    t.text      "invitation_message"
    t.integer   "list_id"
    t.boolean   "hide_flag",                            :default => false,        :null => false
    t.boolean   "delete_flag",                          :default => false,        :null => false
    t.string    "md5_invitation_id",      :limit => 32
    t.integer   "email_communication_id"
    t.timestamp "created_at",                                                     :null => false
    t.timestamp "status_updated_at",                                              :null => false
    t.timestamp "updated_at",                                                     :null => false
    t.string    "facebook_post_id"
  end

  add_index "invitations", ["delete_flag"], :name => "delete_flag_idx"
  add_index "invitations", ["email_communication_id"], :name => "email_communication_id_index"
  add_index "invitations", ["hide_flag"], :name => "hide_flag_idx"
  add_index "invitations", ["list_id"], :name => "list_id_idx"
  add_index "invitations", ["md5_invitation_id"], :name => "md5_invitation_id_index"
  add_index "invitations", ["sn_id"], :name => "sn_id_idx"
  add_index "invitations", ["user_id_from"], :name => "user_id_from_index"
  add_index "invitations", ["user_id_to"], :name => "user_id_to_index"

  create_table "list_bookmarks", :force => true do |t|
    t.integer   "user_id",    :null => false
    t.integer   "list_id",    :null => false
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "list_bookmarks", ["list_id"], :name => "fk_list_bookmarks_list_id"
  add_index "list_bookmarks", ["user_id"], :name => "fk_list_bookmarks_user_id"

  create_table "list_category_scores", :id => false, :force => true do |t|
    t.integer   "list_id",                                      :null => false
    t.integer   "business_type_id",                             :null => false
    t.integer   "number_of_likes",  :limit => 2, :default => 0, :null => false
    t.timestamp "created_at",                                   :null => false
    t.timestamp "updated_at",                                   :null => false
  end

  add_index "list_category_scores", ["business_type_id"], :name => "fk_list_category_scores_tbl_business_types1"
  add_index "list_category_scores", ["list_id"], :name => "list_id"

  create_table "list_category_scores_old", :id => false, :force => true do |t|
    t.integer   "list_id",                                      :null => false
    t.integer   "business_type_id",                             :null => false
    t.integer   "number_of_likes",  :limit => 2, :default => 0, :null => false
    t.integer   "level1"
    t.integer   "level2"
    t.timestamp "created_at",                                   :null => false
    t.timestamp "updated_at",                                   :null => false
  end

  add_index "list_category_scores_old", ["business_type_id"], :name => "fk_list_category_scores_tbl_business_types1"
  add_index "list_category_scores_old", ["list_id", "level1"], :name => "list_id"

  create_table "list_entries", :force => true do |t|
    t.integer   "owner_id",                                      :null => false
    t.string    "type",              :limit => 0,                :null => false
    t.integer   "entry_business_id",                             :null => false
    t.integer   "sn_id",             :limit => 1,                :null => false
    t.integer   "toplist_flag",      :limit => 1, :default => 0, :null => false
    t.timestamp "created_at",                                    :null => false
    t.timestamp "updated_at",                                    :null => false
  end

  add_index "list_entries", ["entry_business_id", "type"], :name => "entry_business_id_type_idx"
  add_index "list_entries", ["entry_business_id", "updated_at", "owner_id"], :name => "idx_entry_business_id_entry_type"
  add_index "list_entries", ["owner_id", "entry_business_id"], :name => "udx_entry_id_entry_type", :unique => true
  add_index "list_entries", ["owner_id", "type"], :name => "owner_id_type_idx"
  add_index "list_entries", ["sn_id"], :name => "sn_id_idx"
  add_index "list_entries", ["type", "toplist_flag", "updated_at"], :name => "idx_owner_type_type_date"

  create_table "list_entries2", :force => true do |t|
    t.integer   "owner_id",                                   :null => false
    t.string    "type",           :limit => 0
    t.integer   "entry_id",                                   :null => false
    t.integer   "data_source_id", :limit => 2, :default => 0, :null => false
    t.timestamp "created_at",                                 :null => false
    t.timestamp "updated_at",                                 :null => false
  end

  add_index "list_entries2", ["entry_id"], :name => "idx_entry_id_entry_type"
  add_index "list_entries2", ["owner_id", "entry_id"], :name => "udx_entry_id_entry_type", :unique => true
  add_index "list_entries2", ["type", "updated_at"], :name => "idx_owner_type_type_date"

  create_table "list_entries_lists", :force => true do |t|
    t.integer   "list_id",       :null => false
    t.integer   "list_entry_id", :null => false
    t.timestamp "created_at",    :null => false
    t.timestamp "updated_at",    :null => false
  end

  add_index "list_entries_lists", ["list_entry_id"], :name => "fk_list_entries_lists_map_list_entries"
  add_index "list_entries_lists", ["list_id"], :name => "fk_list_entries_lists_map_lists"

  create_table "list_geo_category_scores", :id => false, :force => true do |t|
    t.integer   "list_id",                                      :null => false
    t.integer   "city_id",                                      :null => false
    t.integer   "business_type_id",                             :null => false
    t.integer   "number_of_likes",  :limit => 2, :default => 0, :null => false
    t.timestamp "created_at",                                   :null => false
    t.timestamp "updated_at",                                   :null => false
  end

  add_index "list_geo_category_scores", ["business_type_id"], :name => "fk_list_geo_category_scores_tbl_business_types"
  add_index "list_geo_category_scores", ["city_id", "business_type_id"], :name => "list_geo_category_scores_city_level1_idx"
  add_index "list_geo_category_scores", ["city_id", "business_type_id"], :name => "list_geo_category_scores_city_level2_idx"

  create_table "list_geo_category_scores2", :id => false, :force => true do |t|
    t.integer   "list_id",                                      :null => false
    t.integer   "city_id",                                      :null => false
    t.integer   "business_type_id",                             :null => false
    t.integer   "number_of_likes",  :limit => 2, :default => 0, :null => false
    t.timestamp "created_at",                                   :null => false
    t.timestamp "updated_at",                                   :null => false
  end

  add_index "list_geo_category_scores2", ["business_type_id"], :name => "fk_list_geo_category_scores_tbl_business_types"
  add_index "list_geo_category_scores2", ["city_id", "business_type_id"], :name => "list_geo_category_scores_city_level1_idx"
  add_index "list_geo_category_scores2", ["city_id", "business_type_id"], :name => "list_geo_category_scores_city_level2_idx"

  create_table "list_geo_category_scores_old", :id => false, :force => true do |t|
    t.integer   "list_id",                                      :null => false
    t.integer   "city_id",                                      :null => false
    t.integer   "business_type_id",                             :null => false
    t.integer   "level1"
    t.integer   "level2"
    t.integer   "number_of_likes",  :limit => 2, :default => 0, :null => false
    t.timestamp "created_at",                                   :null => false
    t.timestamp "updated_at",                                   :null => false
  end

  add_index "list_geo_category_scores_old", ["business_type_id"], :name => "fk_list_geo_category_scores_tbl_business_types"
  add_index "list_geo_category_scores_old", ["city_id", "business_type_id", "level1"], :name => "list_geo_category_scores_city_level1_idx"
  add_index "list_geo_category_scores_old", ["city_id", "business_type_id", "level2"], :name => "list_geo_category_scores_city_level2_idx"

  create_table "list_geo_scores", :id => false, :force => true do |t|
    t.integer   "list_id",                                     :null => false
    t.integer   "city_id",                                     :null => false
    t.integer   "number_of_likes", :limit => 2, :default => 0, :null => false
    t.timestamp "created_at",                                  :null => false
    t.timestamp "updated_at",                                  :null => false
  end

  add_index "list_geo_scores", ["city_id"], :name => "fk_list_geo_scores_tbl_cities1"

  create_table "list_members", :force => true do |t|
    t.integer   "list_id",                 :null => false
    t.integer   "user_id",                 :null => false
    t.string    "role",       :limit => 0
    t.timestamp "created_at",              :null => false
    t.timestamp "updated_at",              :null => false
  end

  add_index "list_members", ["list_id"], :name => "fk_list_members_list_id"
  add_index "list_members", ["user_id"], :name => "fk_list_members_user_id"

  create_table "list_post_notes", :force => true do |t|
    t.integer   "list_post_thread_id",                             :null => false
    t.integer   "user_id",                          :default => 0, :null => false
    t.text      "notes"
    t.integer   "business_id"
    t.integer   "hide_flag",           :limit => 1, :default => 0, :null => false
    t.timestamp "created_at",                                      :null => false
    t.timestamp "updated_at",                                      :null => false
  end

  add_index "list_post_notes", ["business_id"], :name => "fk_list_bookmarks_business_id"
  add_index "list_post_notes", ["list_post_thread_id"], :name => "fk_list_post_notes_list_post_threads"
  add_index "list_post_notes", ["user_id"], :name => "user_id_idx"

  create_table "list_post_threads", :force => true do |t|
    t.integer   "list_id",                                                :null => false
    t.integer   "stick_to_top_flag",          :limit => 1, :default => 0, :null => false
    t.integer   "original_list_post_note_id"
    t.timestamp "created_at",                                             :null => false
    t.timestamp "updated_at",                                             :null => false
  end

  add_index "list_post_threads", ["list_id"], :name => "fk_list_post_threads_list_id"
  add_index "list_post_threads", ["original_list_post_note_id"], :name => "fk_list_post_threads_original_list_post_note_id"

  create_table "lists", :force => true do |t|
    t.integer   "owner_id",                                                       :null => false
    t.string    "type",             :limit => 0,    :default => "Default",        :null => false
    t.string    "list_name",                        :default => "My LikeList",    :null => false
    t.string    "list_description", :limit => 1024
    t.integer   "is_cool",          :limit => 1,    :default => 0,                :null => false
    t.integer   "impression_count",                 :default => 0,                :null => false
    t.string    "image_file_path"
    t.integer   "hide_flag",        :limit => 1,    :default => 0,                :null => false
    t.string    "add_privileges",   :limit => 0,    :default => "moderator_only", :null => false
    t.timestamp "created_at",                                                     :null => false
    t.timestamp "updated_at",                                                     :null => false
    t.string    "list_name_url",                                                  :null => false
  end

  add_index "lists", ["owner_id", "list_name"], :name => "owner_id"
  add_index "lists", ["owner_id", "list_name_url"], :name => "owner_id_list_name_url_idx", :unique => true
  add_index "lists", ["updated_at"], :name => "updated_at"

  create_table "lists2", :force => true do |t|
    t.integer   "owner_group_id"
    t.string    "type",             :limit => 0,    :default => "Default"
    t.integer   "owner_id",                                                    :null => false
    t.string    "list_name",                        :default => "My LikeList", :null => false
    t.string    "list_description", :limit => 1024
    t.integer   "is_cool",          :limit => 1,    :default => 0,             :null => false
    t.integer   "impression_count",                 :default => 0,             :null => false
    t.string    "image_file_path"
    t.integer   "hide_flag",        :limit => 1
    t.string    "add_priviledges",  :limit => 0
    t.timestamp "created_at",                                                  :null => false
    t.timestamp "updated_at",                                                  :null => false
  end

  add_index "lists2", ["owner_id", "list_name"], :name => "owner_id"
  add_index "lists2", ["updated_at"], :name => "updated_at"

  create_table "location_aliases", :force => true do |t|
    t.integer   "location_id",                                                                   :null => false
    t.string    "alias_name",                                                                    :null => false
    t.string    "alias_state_code", :limit => 2,                                                 :null => false
    t.decimal   "longitude",                      :precision => 18, :scale => 12
    t.decimal   "latitude",                       :precision => 18, :scale => 12
    t.boolean   "preferred_flag",                                                                :null => false
    t.integer   "population_rank",                                                :default => 0, :null => false
    t.integer   "area_rank",        :limit => 1,                                  :default => 0, :null => false
    t.string    "alias_woeid",      :limit => 45
    t.string    "alias_usps_hash",  :limit => 45
    t.timestamp "created_at",                                                                    :null => false
    t.timestamp "updated_at",                                                                    :null => false
  end

  add_index "location_aliases", ["location_id"], :name => "location_id_idx"

  create_table "location_city_distance_to_be_deleted", :id => false, :force => true do |t|
    t.integer "location_id",              :null => false
    t.integer "radius",      :limit => 1, :null => false
    t.float   "distance",    :limit => 5, :null => false
    t.integer "city_id",                  :null => false
  end

  add_index "location_city_distance_to_be_deleted", ["location_id", "radius", "city_id"], :name => "location_id_radius_near_city_id_index"
  add_index "location_city_distance_to_be_deleted", ["location_id", "radius", "distance"], :name => "location_id_radius_distance_index"
  add_index "location_city_distance_to_be_deleted", ["location_id", "radius"], :name => "location_id_radius_index"

  create_table "locations", :force => true do |t|
    t.string    "name",                                                                            :null => false
    t.string    "state_code",         :limit => 2,                                                 :null => false
    t.decimal   "latitude",                         :precision => 18, :scale => 12,                :null => false
    t.decimal   "longitude",                        :precision => 18, :scale => 12,                :null => false
    t.integer   "population_rank",                                                  :default => 0, :null => false
    t.integer   "area_rank",          :limit => 1,                                  :default => 0, :null => false
    t.integer   "location_woeid"
    t.string    "location_usps_hash", :limit => 45
    t.timestamp "created_at",                                                                      :null => false
    t.timestamp "updated_at",                                                                      :null => false
  end

  add_index "locations", ["name", "state_code"], :name => "city_state_idx"

  create_table "locations_postal_codes", :id => false, :force => true do |t|
    t.integer   "location_id",    :null => false
    t.integer   "postal_code_id", :null => false
    t.timestamp "created_at",     :null => false
    t.timestamp "updated_at",     :null => false
  end

  add_index "locations_postal_codes", ["postal_code_id"], :name => "fk_locations_postal_codes_postal_codes1"

  create_table "locations_postal_codes_new", :id => false, :force => true do |t|
    t.integer   "location_id",    :null => false
    t.integer   "postal_code_id", :null => false
    t.timestamp "created_at",     :null => false
    t.timestamp "updated_at",     :null => false
  end

  add_index "locations_postal_codes_new", ["postal_code_id"], :name => "fk_locations_postal_codes_postal_codes1"

  create_table "map_category_biz_type", :id => false, :force => true do |t|
    t.integer "category_id", :null => false
    t.integer "type_id",     :null => false
  end

  create_table "marketing_campaign_businesses", :force => true do |t|
    t.string   "campaign",                       :limit => 50,                     :null => false
    t.string   "activation_code",                :limit => 50
    t.string   "business_name",                                                    :null => false
    t.integer  "business_id",                                                      :null => false
    t.string   "address1"
    t.string   "city_name"
    t.string   "state_code",                     :limit => 2
    t.string   "zip_code",                       :limit => 10
    t.string   "business_type_name",             :limit => 100
    t.string   "delivery_method",                :limit => 50
    t.datetime "delivery_date"
    t.boolean  "activation_code_used_flag",                     :default => false, :null => false
    t.datetime "activation_code_used_timestamp"
  end

  add_index "marketing_campaign_businesses", ["activation_code"], :name => "activation_code_UNIQUE", :unique => true

  create_table "message_recipients", :force => true do |t|
    t.integer   "message_id",                                                :null => false
    t.integer   "recipient_id"
    t.string    "recipient_type",           :limit => 0,                     :null => false
    t.string    "external_recipient_id"
    t.integer   "data_source_id",           :limit => 2,                     :null => false
    t.string    "facebook_post_id"
    t.string    "md5_message_recipient_id", :limit => 32
    t.integer   "email_communication_id"
    t.boolean   "read_flag",                              :default => false, :null => false
    t.boolean   "hide_flag",                              :default => false, :null => false
    t.boolean   "delete_flag",                            :default => false, :null => false
    t.timestamp "created_at",                                                :null => false
    t.timestamp "updated_at",                                                :null => false
  end

  add_index "message_recipients", ["data_source_id"], :name => "fk_message_recipients_tbl_data_sources1"
  add_index "message_recipients", ["delete_flag"], :name => "delete_flag_idx"
  add_index "message_recipients", ["email_communication_id"], :name => "email_communication_id_index"
  add_index "message_recipients", ["external_recipient_id"], :name => "external_recipient_id_idx"
  add_index "message_recipients", ["hide_flag"], :name => "hide_flag_idx"
  add_index "message_recipients", ["md5_message_recipient_id"], :name => "md5_message_recipient_id_index"
  add_index "message_recipients", ["message_id"], :name => "fk_message_recipients_messages1"
  add_index "message_recipients", ["read_flag"], :name => "read_flag_idx"
  add_index "message_recipients", ["recipient_id"], :name => "recipient_id_idx"
  add_index "message_recipients", ["recipient_type"], :name => "recipient_type_idx"

  create_table "message_threads", :force => true do |t|
    t.integer   "ancestor_message_id",                               :null => false
    t.integer   "descendant_message_id",                             :null => false
    t.integer   "depth",                 :limit => 2, :default => 0, :null => false
    t.timestamp "created_at",                                        :null => false
    t.timestamp "updated_at",                                        :null => false
  end

  add_index "message_threads", ["ancestor_message_id", "descendant_message_id"], :name => "ancestor_message_id", :unique => true
  add_index "message_threads", ["ancestor_message_id"], :name => "fk_message_threads_messages"
  add_index "message_threads", ["descendant_message_id"], :name => "fk_message_threads_messages1"

  create_table "messages", :force => true do |t|
    t.integer   "author_id",                 :null => false
    t.string    "author_type",  :limit => 0, :null => false
    t.integer   "topic_id",                  :null => false
    t.string    "topic_type",   :limit => 0, :null => false
    t.string    "subject_line"
    t.text      "message"
    t.string    "message_type", :limit => 0, :null => false
    t.timestamp "created_at",                :null => false
    t.timestamp "updated_at",                :null => false
  end

  add_index "messages", ["author_id"], :name => "author_id_idx"
  add_index "messages", ["author_type"], :name => "author_type_idx"
  add_index "messages", ["message_type"], :name => "message_type_idx"
  add_index "messages", ["topic_id"], :name => "topic_id_idx"
  add_index "messages", ["topic_type"], :name => "topic_type_idx"

  create_table "payment_transactions", :force => true do |t|
    t.integer   "user_purchase_id",                                                                 :null => false
    t.decimal   "amount",                           :precision => 10, :scale => 2,                  :null => false
    t.string    "transaction_id",   :limit => 45
    t.string    "status_cd",        :limit => 45,                                  :default => "0", :null => false
    t.string    "status_message",   :limit => 1024
    t.timestamp "created_at",                                                                       :null => false
    t.timestamp "updated_at",                                                                       :null => false
  end

  add_index "payment_transactions", ["user_purchase_id"], :name => "fk_payment_transactions_user_deal_purchases"

  create_table "postal_codes", :force => true do |t|
    t.string    "postal_code",       :limit => 10,                                                :null => false
    t.integer   "postal_code_woeid"
    t.integer   "population_rank",                                                 :default => 0, :null => false
    t.integer   "area_rank",         :limit => 1,                                  :default => 0, :null => false
    t.decimal   "latitude",                        :precision => 18, :scale => 12
    t.decimal   "longitude",                       :precision => 18, :scale => 12
    t.timestamp "created_at",                                                                     :null => false
    t.timestamp "updated_at",                                                                     :null => false
  end

  create_table "rdsping", :force => true do |t|
    t.timestamp "ts", :null => false
  end

  create_table "report_email_list", :force => true do |t|
    t.string "firstname", :limit => 40,  :null => false
    t.string "lastname",  :limit => 40,  :null => false
    t.string "email",     :limit => 100, :null => false
    t.string "status",    :limit => 0,   :null => false
  end

  add_index "report_email_list", ["email"], :name => "email", :unique => true

  create_table "seo_url_mappings", :primary_key => "url_mapping_id", :force => true do |t|
    t.string    "inbound_url",  :null => false
    t.string    "outbound_url", :null => false
    t.timestamp "created_on",   :null => false
    t.timestamp "modified_on",  :null => false
  end

  add_index "seo_url_mappings", ["inbound_url"], :name => "inbound_url_index"

  create_table "smb_accounts", :primary_key => "account_id", :force => true do |t|
    t.string    "account_name",                                  :null => false
    t.integer   "primary_user_id",                               :null => false
    t.integer   "secondary_user_id"
    t.timestamp "created_on",                                    :null => false
    t.timestamp "modified_on",                                   :null => false
    t.integer   "version",           :limit => 1, :default => 1, :null => false
  end

  add_index "smb_accounts", ["primary_user_id"], :name => "fk_smb_accounts_tbl_users2"
  add_index "smb_accounts", ["secondary_user_id"], :name => "fk_smb_accounts_tbl_users1"

  create_table "smb_accounts_history", :primary_key => "history_id", :force => true do |t|
    t.timestamp "history_ts",                                            :null => false
    t.string    "history_reason",    :limit => 0, :default => "updated", :null => false
    t.integer   "account_id",                                            :null => false
    t.string    "account_name",                                          :null => false
    t.integer   "primary_user_id",                                       :null => false
    t.integer   "secondary_user_id"
    t.timestamp "created_on",                                            :null => false
    t.timestamp "modified_on",                                           :null => false
    t.integer   "version",           :limit => 1, :default => 1,         :null => false
  end

  add_index "smb_accounts_history", ["account_id"], :name => "account_id_index"
  add_index "smb_accounts_history", ["primary_user_id"], :name => "fk_smb_accounts_tbl_users2"
  add_index "smb_accounts_history", ["secondary_user_id"], :name => "fk_smb_accounts_tbl_users1"

  create_table "smb_aria_provisioning_details", :primary_key => "provisioning_detail_id", :force => true do |t|
    t.integer   "business_entity_id",                                   :null => false
    t.integer   "business_id"
    t.integer   "aria_plan_no",           :limit => 8,   :default => 0, :null => false
    t.integer   "aria_account_no"
    t.string    "aria_user_id",           :limit => 100,                :null => false
    t.integer   "aria_status_cd",                                       :null => false
    t.string    "aria_promo_cd",          :limit => 30
    t.integer   "aria_error_code"
    t.string    "aria_error_msg"
    t.timestamp "provisioning_timestamp",                               :null => false
  end

  add_index "smb_aria_provisioning_details", ["aria_status_cd"], :name => "aria_status_cd_index"
  add_index "smb_aria_provisioning_details", ["business_entity_id"], :name => "business_entity_id_index"
  add_index "smb_aria_provisioning_details", ["business_id"], :name => "business_id"

  create_table "smb_aria_provisioning_statuses", :primary_key => "aria_status_cd", :force => true do |t|
    t.string "aria_status_label", :limit => 100, :null => false
  end

  create_table "smb_business_entities", :primary_key => "business_entity_id", :force => true do |t|
    t.string    "business_name",                                                 :null => false
    t.integer   "city_id",                                      :default => 0,   :null => false
    t.string    "state_code",                     :limit => 2
    t.integer   "account_id",                                                    :null => false
    t.string    "address1"
    t.string    "address2"
    t.string    "primary_phone",                  :limit => 20, :default => "0", :null => false
    t.string    "zip_code",                       :limit => 10
    t.integer   "current_provisioning_detail_id"
    t.string    "current_provisioning_source",    :limit => 0
    t.timestamp "created_on",                                                    :null => false
    t.timestamp "modified_on",                                                   :null => false
    t.integer   "version",                        :limit => 1
  end

  add_index "smb_business_entities", ["account_id"], :name => "account_id_index"

  create_table "smb_business_entities_history", :primary_key => "history_id", :force => true do |t|
    t.timestamp "history_ts",                                              :null => false
    t.string    "history_reason",     :limit => 0,  :default => "updated", :null => false
    t.integer   "business_entity_id",                                      :null => false
    t.string    "business_name",                                           :null => false
    t.integer   "city_id",                          :default => 0,         :null => false
    t.string    "state_code",         :limit => 2
    t.integer   "account_id",                                              :null => false
    t.string    "address1"
    t.string    "address2"
    t.string    "primary_phone",      :limit => 20,                        :null => false
    t.string    "zip_code",           :limit => 10
    t.timestamp "created_on",                                              :null => false
    t.timestamp "modified_on",                                             :null => false
    t.integer   "version",            :limit => 1,  :default => 1
  end

  add_index "smb_business_entities_history", ["account_id"], :name => "account_id_index"
  add_index "smb_business_entities_history", ["business_entity_id"], :name => "business_entity_id_index"

  create_table "smb_categories_to_be_delete", :primary_key => "category_id", :force => true do |t|
    t.string  "category_name", :limit => 100, :null => false
    t.string  "source",        :limit => 0,   :null => false
    t.integer "source_id"
  end

  add_index "smb_categories_to_be_delete", ["category_name", "source", "source_id"], :name => "name_source_id_idx", :unique => true
  add_index "smb_categories_to_be_delete", ["source_id"], :name => "source_id_index"

  create_table "smb_created_business_listings", :primary_key => "smb_bl_id", :force => true do |t|
    t.string    "business_name",                                           :null => false
    t.integer   "business_type_id",                       :default => 0,   :null => false
    t.integer   "business_user_id",         :limit => 8,  :default => 0,   :null => false
    t.string    "address1"
    t.string    "address2"
    t.integer   "city_id",                                :default => 0,   :null => false
    t.string    "state_code",               :limit => 2
    t.string    "zip_code",                 :limit => 10, :default => "0"
    t.string    "business_phone",           :limit => 20
    t.string    "business_secondary_phone", :limit => 20
    t.string    "business_tertiary_phone",  :limit => 20
    t.string    "website"
    t.string    "business_info"
    t.float     "latitude",                               :default => 0.0
    t.float     "longitude",                              :default => 0.0
    t.timestamp "created_on",                                              :null => false
    t.timestamp "modified_on",                                             :null => false
    t.string    "is_deleted",               :limit => 0,  :default => "N"
    t.string    "city"
    t.string    "is_rated",                 :limit => 1,  :default => "N"
    t.string    "source_external_id",       :limit => 50, :default => "0", :null => false
    t.string    "user_entered_category"
  end

  add_index "smb_created_business_listings", ["business_info"], :name => "business_phone_index"
  add_index "smb_created_business_listings", ["city_id"], :name => "city_id_index"
  add_index "smb_created_business_listings", ["latitude"], :name => "latitude_index"
  add_index "smb_created_business_listings", ["longitude"], :name => "longitude_index"
  add_index "smb_created_business_listings", ["source_external_id"], :name => "source_external_index"
  add_index "smb_created_business_listings", ["state_code"], :name => "state_code_index"
  add_index "smb_created_business_listings", ["zip_code"], :name => "zip_code_index"

  create_table "smb_dashboards", :primary_key => "smb_dashboard_id", :force => true do |t|
    t.integer   "business_id",                                            :null => false
    t.integer   "business_entity_id"
    t.integer   "business_listing_impressions_last_day",   :default => 0, :null => false
    t.integer   "business_listing_click_thrus_last_day",   :default => 0, :null => false
    t.integer   "clicks_on_url_last_day",                  :default => 0, :null => false
    t.integer   "business_listing_impressions_this_week",  :default => 0, :null => false
    t.integer   "business_listing_click_thrus_this_week",  :default => 0, :null => false
    t.integer   "clicks_on_url_this_week",                 :default => 0, :null => false
    t.integer   "business_listing_impressions_last_week",  :default => 0, :null => false
    t.integer   "business_listing_click_thrus_last_week",  :default => 0, :null => false
    t.integer   "clicks_on_url_last_week",                 :default => 0, :null => false
    t.integer   "business_listing_impressions_this_month", :default => 0, :null => false
    t.integer   "business_listing_click_thrus_this_month", :default => 0, :null => false
    t.integer   "clicks_on_url_this_month",                :default => 0, :null => false
    t.integer   "business_listing_impressions_last_month", :default => 0, :null => false
    t.integer   "business_listing_click_thrus_last_month", :default => 0, :null => false
    t.integer   "clicks_on_url_last_month",                :default => 0, :null => false
    t.integer   "business_listing_impressions_total",      :default => 0, :null => false
    t.integer   "business_listing_click_thrus_total",      :default => 0, :null => false
    t.integer   "clicks_on_url_total",                     :default => 0, :null => false
    t.timestamp "created_on",                                             :null => false
    t.timestamp "last_update",                                            :null => false
  end

  add_index "smb_dashboards", ["business_entity_id"], :name => "business_entity_id_index"
  add_index "smb_dashboards", ["business_id"], :name => "business_id_index", :unique => true

  create_table "smb_dashboards_wrk", :id => false, :force => true do |t|
    t.integer "logging_event_id",                                 :null => false
    t.integer "business_id",                                      :null => false
    t.integer "event_count",                       :default => 0, :null => false
    t.string  "logging_event_name", :limit => 100
    t.date    "event_date",                                       :null => false
  end

  add_index "smb_dashboards_wrk", ["business_id"], :name => "business_id_index"
  add_index "smb_dashboards_wrk", ["logging_event_id", "business_id", "event_date"], :name => "event_business_date_index", :unique => true
  add_index "smb_dashboards_wrk", ["logging_event_id"], :name => "logging_event_id_index"
  add_index "smb_dashboards_wrk", ["logging_event_name"], :name => "logging_event_name_index"

  create_table "smb_issue_topics", :primary_key => "topic_id", :force => true do |t|
    t.integer "parent_topic_id", :default => 0, :null => false
    t.string  "topic_name"
  end

  create_table "smb_issues", :primary_key => "issue_id", :force => true do |t|
    t.integer "user_id"
    t.integer "account_id"
    t.integer "business_id",                                                  :null => false
    t.string  "contact_name"
    t.string  "phone_number",             :limit => 20
    t.string  "email_address",            :limit => 100
    t.string  "preferred_contact_method", :limit => 0,   :default => "email", :null => false
    t.integer "topic_id",                                                     :null => false
    t.text    "comments"
    t.string  "resolution_disposition",   :limit => 0,   :default => "open",  :null => false
  end

  add_index "smb_issues", ["account_id"], :name => "account_id_index"
  add_index "smb_issues", ["business_id"], :name => "business_id_index"
  add_index "smb_issues", ["topic_id"], :name => "topic_id_index"
  add_index "smb_issues", ["user_id"], :name => "fk_smb_contact_al_issues_tbl_users1"

  create_table "smb_promo_messages", :primary_key => "message_id", :force => true do |t|
    t.integer   "business_id",                                                                                     :null => false
    t.string    "one_min_message",                                                                                 :null => false
    t.string    "message_type",              :limit => 0,                                   :default => "message", :null => false
    t.timestamp "start_timestamp",                                                                                 :null => false
    t.timestamp "end_timestamp",                                                                                   :null => false
    t.boolean   "email_before_expires_flag",                                                :default => false,     :null => false
    t.boolean   "email_sent_flag",                                                          :default => false,     :null => false
    t.integer   "impression_count",                                                         :default => 0,         :null => false
    t.integer   "click_thru_count",                                                         :default => 0,         :null => false
    t.timestamp "created_on",                                                                                      :null => false
    t.timestamp "modified_on",                                                                                     :null => false
    t.integer   "version",                   :limit => 1
    t.string    "message_title"
    t.string    "offer_url"
    t.string    "message_terms",             :limit => 2048
    t.integer   "data_source_id",            :limit => 2,                                   :default => 0,         :null => false
    t.integer   "city_id",                                                                                         :null => false
    t.integer   "transaction_term_id",       :limit => 2
    t.timestamp "deal_start_timestamp"
    t.timestamp "deal_end_timestamp"
    t.string    "image_file_path"
    t.decimal   "purchase_price",                            :precision => 10, :scale => 2
    t.decimal   "retail_value",                              :precision => 10, :scale => 2
    t.integer   "max_quantity_per_person"
    t.integer   "min_quantity_per_person"
    t.integer   "max_quantity_provided"
    t.integer   "quantity_purchased"
    t.text      "description"
    t.string    "gift_headline"
  end

  add_index "smb_promo_messages", ["business_id"], :name => "business_id_index"
  add_index "smb_promo_messages", ["city_id"], :name => "city_id_idx"
  add_index "smb_promo_messages", ["end_timestamp", "start_timestamp", "business_id", "message_type"], :name => "end_start_time_biz_id_message_type_idx"
  add_index "smb_promo_messages", ["end_timestamp"], :name => "end_timestamp_index"
  add_index "smb_promo_messages", ["message_type", "start_timestamp", "end_timestamp", "business_id"], :name => "message_type_start_end_time_business_idx"
  add_index "smb_promo_messages", ["start_timestamp", "end_timestamp", "message_type"], :name => "start_end_time_message_type_idx"

  create_table "smb_promo_messages_copy_do_not_delete", :primary_key => "message_id", :force => true do |t|
    t.integer   "business_id",                                                     :null => false
    t.string    "one_min_message",           :limit => 125,                        :null => false
    t.string    "message_type",              :limit => 0,   :default => "message", :null => false
    t.timestamp "start_timestamp",                                                 :null => false
    t.timestamp "end_timestamp",                                                   :null => false
    t.boolean   "archive_flag",                             :default => false,     :null => false
    t.boolean   "email_before_expires_flag",                :default => false,     :null => false
    t.boolean   "email_sent_flag",                          :default => false,     :null => false
    t.integer   "impression_count",                         :default => 0,         :null => false
    t.integer   "click_thru_count",                         :default => 0,         :null => false
    t.timestamp "created_on",                                                      :null => false
    t.timestamp "modified_on",                                                     :null => false
    t.integer   "version",                   :limit => 1
  end

  add_index "smb_promo_messages_copy_do_not_delete", ["business_id"], :name => "business_id_index"
  add_index "smb_promo_messages_copy_do_not_delete", ["end_timestamp"], :name => "end_timestamp_index"

  create_table "smb_promo_messages_history", :primary_key => "history_id", :force => true do |t|
    t.timestamp "history_ts",                                                                                      :null => false
    t.string    "history_reason",            :limit => 0,                                   :default => "updated", :null => false
    t.integer   "message_id",                                                                                      :null => false
    t.integer   "business_id",                                                                                     :null => false
    t.string    "one_min_message",                                                                                 :null => false
    t.string    "message_type",              :limit => 0,                                   :default => "message", :null => false
    t.timestamp "start_timestamp",                                                                                 :null => false
    t.timestamp "end_timestamp",                                                                                   :null => false
    t.integer   "click_thru_count",                                                         :default => 0,         :null => false
    t.timestamp "created_on",                                                                                      :null => false
    t.timestamp "modified_on",                                                                                     :null => false
    t.integer   "version",                   :limit => 1,                                   :default => 1
    t.string    "message_title"
    t.string    "offer_url"
    t.string    "message_terms",             :limit => 2048
    t.integer   "data_source_id",            :limit => 2
    t.integer   "city_id"
    t.integer   "transaction_term_id",       :limit => 2
    t.timestamp "deal_start_timestamp"
    t.timestamp "deal_end_timestamp"
    t.string    "image_file_path"
    t.decimal   "purchase_price",                            :precision => 10, :scale => 2
    t.decimal   "retail_value",                              :precision => 10, :scale => 2
    t.integer   "max_quantity_per_person"
    t.integer   "min_quantity_per_person"
    t.integer   "max_quantity_provided"
    t.integer   "quantity_purchased"
    t.string    "description",               :limit => 2048
    t.string    "gift_headline"
    t.boolean   "email_before_expires_flag",                                                :default => false,     :null => false
    t.boolean   "email_sent_flag",                                                          :default => false,     :null => false
    t.integer   "impression_count",                                                         :default => 0,         :null => false
  end

  add_index "smb_promo_messages_history", ["business_id"], :name => "business_id_index"
  add_index "smb_promo_messages_history", ["message_id"], :name => "message_id_index"

  create_table "smb_promo_sites", :primary_key => "promo_site_id", :force => true do |t|
    t.integer "business_id",                                                   :null => false
    t.string  "slogan",                      :limit => 120
    t.string  "business_summary",            :limit => 240
    t.string  "what_makes_us_different",     :limit => 240
    t.boolean "pm_amex_accepted_flag",                      :default => false, :null => false
    t.boolean "pm_cash_accepted_flag",                      :default => false, :null => false
    t.boolean "pm_check_accepted_flag",                     :default => false, :null => false
    t.boolean "pm_moneyorder_accepted_flag",                :default => false, :null => false
    t.boolean "pm_paypal_accepted_flag",                    :default => false, :null => false
    t.boolean "pm_debitcard_accepted_flag",                 :default => false, :null => false
    t.boolean "pm_bankwire_accepted_flag",                  :default => false, :null => false
    t.boolean "pm_visa_accepted_flag",                      :default => false, :null => false
    t.boolean "pm_mastercard_accepted_flag",                :default => false, :null => false
    t.boolean "pm_discover_accepted_flag",                  :default => false, :null => false
    t.string  "license_number",              :limit => 120
    t.boolean "hide_license_flag",                          :default => false, :null => false
    t.integer "cust_comment1_user_id"
    t.integer "cust_comment2_user_id"
    t.integer "cust_comment3_user_id"
    t.string  "logo_image_file_path",        :limit => 150
    t.string  "photo_image_file_path",       :limit => 150
  end

  add_index "smb_promo_sites", ["business_id"], :name => "business_id_index"
  add_index "smb_promo_sites", ["cust_comment1_user_id"], :name => "cust_comment1_user_id_index"
  add_index "smb_promo_sites", ["cust_comment2_user_id"], :name => "cust_comment2_user_id_index"
  add_index "smb_promo_sites", ["cust_comment3_user_id"], :name => "cust_comment3_user_id_index"

  create_table "snp_attributes_foursquare", :primary_key => "snp_id", :force => true do |t|
    t.integer   "user_id",                                                  :null => false
    t.integer   "checkin_threshold",      :limit => 2,   :default => 0,     :null => false
    t.boolean   "convert_mayorship_flag",                :default => false, :null => false
    t.string    "twitter_user_name",      :limit => 100
    t.string    "facebook_user_id",       :limit => 45
    t.timestamp "created_on",                                               :null => false
    t.timestamp "modified_on",                                              :null => false
  end

  create_table "social_network_attributes_to_be_delete", :id => false, :force => true do |t|
    t.integer "sn_id",      :limit => 1, :null => false
    t.integer "sn_user_id", :limit => 8, :null => false
    t.string  "the_key"
    t.string  "the_value"
  end

  add_index "social_network_attributes_to_be_delete", ["sn_id", "sn_user_id"], :name => "sn_id_sn_user_id_index"

  create_table "social_network_profiles", :force => true do |t|
    t.integer   "sn_id",                           :limit => 1,                           :null => false
    t.string    "sn_user_id",                      :limit => 50,                          :null => false
    t.integer   "user_id",                                                                :null => false
    t.string    "full_name"
    t.string    "email"
    t.integer   "sn_profile_update_utc",           :limit => 8,        :default => 0,     :null => false
    t.string    "sn_user_details_md5",             :limit => 32
    t.timestamp "created_at",                                                             :null => false
    t.timestamp "updated_at",                                                             :null => false
    t.boolean   "email_confirmed_flag",                                :default => false, :null => false
    t.boolean   "import_from_sn_flag",                                                    :null => false
    t.string    "email_verification_code",         :limit => 150
    t.timestamp "email_verification_timestamp",                                           :null => false
    t.string    "user_name",                       :limit => 100
    t.string    "authentication_token"
    t.string    "access_token"
    t.string    "access_token_secret"
    t.boolean   "import_friends_flag",                                 :default => false, :null => false
    t.text      "authentication_data",             :limit => 16777215
    t.integer   "checkin_threshold",               :limit => 2,        :default => 0,     :null => false
    t.integer   "checkin_threshold_override_flag", :limit => 1,        :default => 0,     :null => false
  end

  add_index "social_network_profiles", ["email"], :name => "email_index"
  add_index "social_network_profiles", ["email_verification_code"], :name => "email_verification_code"
  add_index "social_network_profiles", ["sn_id", "email"], :name => "sn_id_email"
  add_index "social_network_profiles", ["sn_id", "sn_user_id"], :name => "sn_id_sn_user_id_index", :unique => true
  add_index "social_network_profiles", ["sn_id", "user_id"], :name => "sn_id", :unique => true
  add_index "social_network_profiles", ["sn_id"], :name => "sn_id_index"
  add_index "social_network_profiles", ["sn_user_id"], :name => "sn_user_id_index"
  add_index "social_network_profiles", ["user_id"], :name => "user_id_index"
  add_index "social_network_profiles", ["user_name"], :name => "user_name_idx", :length => {"user_name"=>"50"}

  create_table "social_networks", :force => true do |t|
    t.integer   "sn_id",      :limit => 1,  :null => false
    t.string    "sn_name",    :limit => 64, :null => false
    t.timestamp "created_on",               :null => false
  end

  add_index "social_networks", ["sn_id"], :name => "sn_id_index", :unique => true
  add_index "social_networks", ["sn_name"], :name => "sn_name_index", :unique => true

  create_table "staging_marketing_test_businesses", :force => true do |t|
    t.string   "business_type_name", :limit => 100
    t.string   "business_name",                                                                      :null => false
    t.integer  "business_id",                                                       :default => 0,   :null => false
    t.string   "address1"
    t.string   "city_name",                                                                          :null => false
    t.string   "state_code",         :limit => 2,                                                    :null => false
    t.string   "zip_code",           :limit => 10,                                  :default => "0"
    t.decimal  "like_count",                         :precision => 23, :scale => 0
    t.float    "rand",               :limit => 17
    t.string   "activation_code1",   :limit => 5
    t.string   "delivery_method1",   :limit => 10
    t.datetime "delivery_date1"
    t.string   "activation_code2",   :limit => 5
    t.string   "delivery_method2",   :limit => 10
    t.datetime "delivery_date2"
    t.string   "note",               :limit => 2048
    t.string   "var1",               :limit => 50
    t.string   "var2",               :limit => 50
    t.string   "var3"
    t.string   "var4",               :limit => 50
    t.string   "var5",               :limit => 50
  end

  create_table "tbl_account_updates", :force => true do |t|
    t.integer   "user_id",                                     :null => false
    t.string    "login_name",  :limit => 100
    t.string    "first_name",  :limit => 100
    t.string    "last_name",   :limit => 100
    t.timestamp "modified_on",                                 :null => false
    t.string    "code",        :limit => 1,                    :null => false
    t.string    "is_indexed",  :limit => 1,   :default => "n", :null => false
  end

  add_index "tbl_account_updates", ["is_indexed"], :name => "is_indexed_index"
  add_index "tbl_account_updates", ["modified_on"], :name => "modified_on_index"

  create_table "tbl_activity_log", :force => true do |t|
    t.integer   "activity_id", :null => false
    t.integer   "user_id",     :null => false
    t.integer   "resource_id", :null => false
    t.timestamp "action_time", :null => false
  end

  add_index "tbl_activity_log", ["activity_id"], :name => "activity_id_index"
  add_index "tbl_activity_log", ["user_id", "activity_id", "resource_id"], :name => "user_id_activity_id_resource_id_index"
  add_index "tbl_activity_log", ["user_id"], :name => "user_id_index"

  create_table "tbl_alikelist_stats", :id => false, :force => true do |t|
    t.integer "cities_covered",       :null => false
    t.integer "total_businesses",     :null => false
    t.integer "total_business_types", :null => false
  end

  create_table "tbl_analytics_search_history", :id => false, :force => true do |t|
    t.timestamp "search_dt",                                       :null => false
    t.string    "search_type",         :limit => 0
    t.integer   "business_id"
    t.integer   "category_id"
    t.integer   "city_id",                                         :null => false
    t.integer   "user_id"
    t.string    "session_id"
    t.string    "client_ip"
    t.string    "browser_info"
    t.string    "page_url"
    t.string    "text_normalized",                                 :null => false
    t.string    "location_normalized",                             :null => false
    t.float     "latitude"
    t.float     "longitude"
    t.integer   "radius"
    t.integer   "results_count",                    :default => 0, :null => false
  end

  create_table "tbl_ask_requests", :primary_key => "ask_request_id", :force => true do |t|
    t.integer   "ask_request_gpid",                       :default => 0,          :null => false
    t.integer   "ask_request_from",                                               :null => false
    t.integer   "ask_request_to",                                                 :null => false
    t.string    "ask_request_to_email_id",                                        :null => false
    t.string    "to_first_name"
    t.string    "to_last_name",                                                   :null => false
    t.string    "ask_search_for",          :limit => 250,                         :null => false
    t.integer   "city_id",                                                        :null => false
    t.string    "state_code",              :limit => 2,                           :null => false
    t.timestamp "ask_request_sent_on",                                            :null => false
    t.string    "ask_request_status",      :limit => 0,   :default => "pending"
    t.string    "ask_request_type",        :limit => 0,   :default => "multiple"
    t.timestamp "action_time",                                                    :null => false
    t.text      "ask_request_message",                                            :null => false
    t.string    "inbox_status",            :limit => 0,   :default => "unread",   :null => false
    t.string    "response_flag",           :limit => 0,   :default => "f",        :null => false
  end

  add_index "tbl_ask_requests", ["ask_request_to", "inbox_status"], :name => "ask_request_to_inbox_status_index"
  add_index "tbl_ask_requests", ["ask_request_to"], :name => "ask_request_to_index"
  add_index "tbl_ask_requests", ["city_id"], :name => "city_id_index"

  create_table "tbl_ask_response", :primary_key => "ask_response_id", :force => true do |t|
    t.integer   "ask_request_id",                                             :null => false
    t.integer   "ask_request_gpid",                                           :null => false
    t.integer   "ask_response_from",                                          :null => false
    t.integer   "ask_response_to",                                            :null => false
    t.string    "to_first_name"
    t.string    "to_last_name",                                               :null => false
    t.string    "from_email",           :limit => 100,                        :null => false
    t.string    "from_first_name",                                            :null => false
    t.string    "from_last_name",                                             :null => false
    t.integer   "business_type_id",                                           :null => false
    t.timestamp "ask_response_sent_on",                                       :null => false
    t.string    "ask_response_status",  :limit => 0,   :default => "pending"
    t.timestamp "action_time",                                                :null => false
    t.text      "ask_response_message",                                       :null => false
    t.string    "inbox_status",         :limit => 0,   :default => "unread",  :null => false
  end

  add_index "tbl_ask_response", ["ask_request_id"], :name => "ask_request_id_index"
  add_index "tbl_ask_response", ["ask_response_from"], :name => "ask_response_from_index"
  add_index "tbl_ask_response", ["ask_response_status"], :name => "ask_response_status_index"
  add_index "tbl_ask_response", ["ask_response_to", "inbox_status"], :name => "ask_response_to_inbox_status_index"
  add_index "tbl_ask_response", ["ask_response_to"], :name => "ask_response_to_index"
  add_index "tbl_ask_response", ["business_type_id"], :name => "business_type_id_index"

  create_table "tbl_asklist_details_to_be_deleted", :force => true do |t|
    t.integer "ask_list_id"
    t.integer "user_id"
    t.string  "first_name",    :limit => 128
    t.string  "last_name",     :limit => 128
    t.string  "email_id",      :limit => 128
    t.string  "delete_status", :limit => 1
  end

  create_table "tbl_asklist_master_to_be_deleted", :primary_key => "ask_list_id", :force => true do |t|
    t.integer  "ask_list_created_by"
    t.string   "ask_list_name",        :limit => 100
    t.datetime "ask_list_created_on"
    t.datetime "ask_list_modified_on"
  end

  add_index "tbl_asklist_master_to_be_deleted", ["ask_list_created_by"], :name => "ask_list_created_by_index"

  create_table "tbl_biz_dup", :primary_key => "factual_id", :force => true do |t|
    t.integer "ct", :null => false
  end

  create_table "tbl_biz_to_biz_types_to_be_delete", :id => false, :force => true do |t|
    t.integer "business_id",                         :null => false
    t.integer "business_type_id",                    :null => false
    t.string  "is_primary",             :limit => 1, :null => false
    t.string  "business_type_path_seq",              :null => false
    t.integer "level1"
    t.integer "businessid_level1_Key",  :limit => 8
    t.integer "level2"
    t.integer "level3"
  end

  add_index "tbl_biz_to_biz_types_to_be_delete", ["business_id"], :name => "business_id_index"
  add_index "tbl_biz_to_biz_types_to_be_delete", ["business_type_id"], :name => "business_type_id_index"
  add_index "tbl_biz_to_biz_types_to_be_delete", ["level1"], :name => "level1_index"
  add_index "tbl_biz_to_biz_types_to_be_delete", ["level2"], :name => "level2_index"
  add_index "tbl_biz_to_biz_types_to_be_delete", ["level3"], :name => "level3_index"

  create_table "tbl_business_rating_history", :primary_key => "history_id", :force => true do |t|
    t.timestamp "history_ts",                                               :null => false
    t.string    "history_reason",       :limit => 0, :default => "updated", :null => false
    t.integer   "id",                                                       :null => false
    t.integer   "businesses_id",                                            :null => false
    t.integer   "user_list_id",                                             :null => false
    t.text      "note_text",                                                :null => false
    t.string    "list_type",            :limit => 0,                        :null => false
    t.timestamp "rated_on",                                                 :null => false
    t.string    "is_deleted",           :limit => 0, :default => "N",       :null => false
    t.integer   "merge_to_business_id",              :default => 0,         :null => false
  end

  add_index "tbl_business_rating_history", ["businesses_id", "user_list_id", "list_type"], :name => "Business_UserId_Index", :unique => true
  add_index "tbl_business_rating_history", ["businesses_id"], :name => "businesses_id_index"
  add_index "tbl_business_rating_history", ["is_deleted", "list_type", "user_list_id"], :name => "is_deleted_list_type_user_list_id_index"
  add_index "tbl_business_rating_history", ["is_deleted"], :name => "is_deleted_index"

  create_table "tbl_business_rating_to_be_deleted", :force => true do |t|
    t.integer   "businesses_id",                                :null => false
    t.integer   "user_list_id",                                 :null => false
    t.text      "note_text",                                    :null => false
    t.string    "list_type",      :limit => 0,                  :null => false
    t.timestamp "rated_on",                                     :null => false
    t.timestamp "modified_on",                                  :null => false
    t.string    "is_deleted",     :limit => 0, :default => "N", :null => false
    t.integer   "city_id",                                      :null => false
    t.integer   "rated_on_uts",   :limit => 8,                  :null => false
    t.integer   "data_source_id", :limit => 2, :default => 0,   :null => false
  end

  add_index "tbl_business_rating_to_be_deleted", ["businesses_id", "is_deleted"], :name => "businesses_id_is_deleted_index"
  add_index "tbl_business_rating_to_be_deleted", ["businesses_id", "user_list_id"], :name => "Business_UserId_Index", :unique => true
  add_index "tbl_business_rating_to_be_deleted", ["businesses_id"], :name => "businesses_id_index"
  add_index "tbl_business_rating_to_be_deleted", ["city_id"], :name => "city_id_index"
  add_index "tbl_business_rating_to_be_deleted", ["is_deleted", "list_type", "user_list_id"], :name => "is_deleted_list_type_user_list_id_index"
  add_index "tbl_business_rating_to_be_deleted", ["is_deleted", "list_type"], :name => "is_deleted_list_type_index"
  add_index "tbl_business_rating_to_be_deleted", ["is_deleted"], :name => "is_deleted_index"
  add_index "tbl_business_rating_to_be_deleted", ["rated_on", "list_type", "is_deleted"], :name => "rated_on_idx"
  add_index "tbl_business_rating_to_be_deleted", ["rated_on_uts"], :name => "rated_on_uts_index"
  add_index "tbl_business_rating_to_be_deleted", ["user_list_id", "list_type", "is_deleted"], :name => "user_list_id_list_type_is_deleted_index"
  add_index "tbl_business_rating_to_be_deleted", ["user_list_id"], :name => "user_list_id_index"

  create_table "tbl_business_types_to_be_delete", :primary_key => "business_type_id", :force => true do |t|
    t.string  "business_type_name",      :limit => 100
    t.integer "parent_business_type_id",                :default => 0,   :null => false
    t.text    "business_type_path"
    t.string  "business_type_path2"
    t.string  "business_type_path_seq"
    t.integer "category_id",                            :default => 0,   :null => false
    t.string  "is_leaf",                 :limit => 1
    t.string  "is_visible",              :limit => 1,   :default => "1"
    t.integer "al_golden_node_id",                      :default => 0
    t.integer "level_id",                               :default => 0
    t.string  "url_business_type",                                       :null => false
  end

  add_index "tbl_business_types_to_be_delete", ["al_golden_node_id"], :name => "al_golden_node_idx"
  add_index "tbl_business_types_to_be_delete", ["business_type_name"], :name => "business_type_name_index"
  add_index "tbl_business_types_to_be_delete", ["category_id"], :name => "syph_id_index"
  add_index "tbl_business_types_to_be_delete", ["is_leaf"], :name => "is_leaf_idx"
  add_index "tbl_business_types_to_be_delete", ["level_id"], :name => "leve_id_idx"
  add_index "tbl_business_types_to_be_delete", ["parent_business_type_id"], :name => "parent_id_index"
  add_index "tbl_business_types_to_be_delete", ["url_business_type"], :name => "url_business_type_idx"

  create_table "tbl_businesses", :primary_key => "business_id", :force => true do |t|
    t.string    "business_name",                                                    :null => false
    t.integer   "business_type_id",                         :default => 0,          :null => false
    t.integer   "business_user_id",         :limit => 8,    :default => 0,          :null => false
    t.string    "address1"
    t.string    "address2"
    t.integer   "city_id",                                                          :null => false
    t.string    "state_code",               :limit => 2
    t.string    "zip_code",                 :limit => 10,   :default => "0"
    t.string    "business_phone",           :limit => 20
    t.string    "business_secondary_phone", :limit => 20
    t.string    "business_tertiary_phone",  :limit => 20
    t.string    "website",                  :limit => 1024
    t.string    "business_info"
    t.float     "latitude",                                 :default => 0.0
    t.float     "longitude",                                :default => 0.0
    t.timestamp "created_on",                                                       :null => false
    t.timestamp "modified_on",                                                      :null => false
    t.string    "is_deleted",               :limit => 0,    :default => "N"
    t.string    "source",                   :limit => 0,    :default => "al",       :null => false
    t.string    "city"
    t.string    "is_rated",                 :limit => 1,    :default => "N"
    t.string    "source_external_id",       :limit => 50,   :default => "0",        :null => false
    t.string    "reindex",                  :limit => 1,    :default => "N"
    t.integer   "version",                  :limit => 1
    t.integer   "category_id"
    t.integer   "business_entity_id"
    t.timestamp "claimed_on",                                                       :null => false
    t.string    "email_display_name",       :limit => 100
    t.boolean   "hide_address_flag",                        :default => false,      :null => false
    t.string    "al_provisioning_status",   :limit => 0,    :default => "inactive", :null => false
    t.string    "default_image_file_path",  :limit => 150
    t.text      "keywords"
    t.integer   "parent_business_id"
    t.string    "factual_id",               :limit => 36,                           :null => false
    t.integer   "postal_code_id"
    t.string    "po_box"
    t.string    "country",                  :limit => 100,  :default => "US",       :null => false
    t.string    "fax",                      :limit => 50
    t.string    "email"
    t.string    "status",                   :limit => 10
  end

  add_index "tbl_businesses", ["business_entity_id"], :name => "business_entity_id_index"
  add_index "tbl_businesses", ["business_name"], :name => "business_name_index"
  add_index "tbl_businesses", ["business_type_id"], :name => "business_type_id_index"
  add_index "tbl_businesses", ["category_id"], :name => "category_id_index"
  add_index "tbl_businesses", ["city_id"], :name => "city_id_index"
  add_index "tbl_businesses", ["factual_id"], :name => "factual_id_index"
  add_index "tbl_businesses", ["postal_code_id"], :name => "postal_code_id_index"

  create_table "tbl_businesses_history", :primary_key => "history_id", :force => true do |t|
    t.timestamp "history_ts",                                                      :null => false
    t.string    "history_reason",           :limit => 0,   :default => "updated",  :null => false
    t.integer   "business_id",                                                     :null => false
    t.string    "business_name",                                                   :null => false
    t.integer   "business_type_id",                                                :null => false
    t.integer   "business_user_id",         :limit => 8,                           :null => false
    t.string    "address1"
    t.string    "address2"
    t.integer   "city_id",                                                         :null => false
    t.string    "state_code",               :limit => 2
    t.string    "zip_code",                 :limit => 10
    t.string    "business_phone",           :limit => 20
    t.string    "business_secondary_phone", :limit => 20
    t.string    "business_tertiary_phone",  :limit => 20
    t.string    "website"
    t.string    "business_info"
    t.float     "latitude"
    t.float     "longitude"
    t.timestamp "created_on",                                                      :null => false
    t.timestamp "modified_on",                                                     :null => false
    t.string    "is_deleted",               :limit => 0
    t.string    "source",                   :limit => 0,                           :null => false
    t.string    "city"
    t.string    "is_rated",                 :limit => 1
    t.string    "source_external_id",       :limit => 50,                          :null => false
    t.string    "reindex",                  :limit => 1
    t.integer   "version",                  :limit => 1
    t.integer   "category_id"
    t.integer   "business_entity_id"
    t.timestamp "claimed_on",                                                      :null => false
    t.string    "email_display_name",       :limit => 100
    t.boolean   "hide_address_flag",                       :default => false,      :null => false
    t.string    "al_provisioning_status",   :limit => 0,   :default => "inactive", :null => false
    t.string    "default_image_file_path",  :limit => 150
    t.text      "keywords"
    t.integer   "parent_business_id"
    t.integer   "merge_to_business_id",                    :default => 0,          :null => false
  end

  add_index "tbl_businesses_history", ["business_id"], :name => "business_id_index"
  add_index "tbl_businesses_history", ["source_external_id"], :name => "source_external_index"

  create_table "tbl_cities", :primary_key => "city_id", :force => true do |t|
    t.string  "city_name",                              :null => false
    t.string  "state_code", :limit => 2,                :null => false
    t.float   "Latitude",                               :null => false
    t.float   "Longitude",                              :null => false
    t.integer "population",              :default => 0
  end

  add_index "tbl_cities", ["city_name", "state_code"], :name => "city_name_state_code_index"
  add_index "tbl_cities", ["city_name"], :name => "city_name"
  add_index "tbl_cities", ["state_code"], :name => "state_code"

  create_table "tbl_city_distance", :id => false, :force => true do |t|
    t.integer "city_id",                   :null => false
    t.integer "radius",       :limit => 1, :null => false
    t.float   "distance",     :limit => 5, :null => false
    t.integer "near_city_id",              :null => false
  end

  add_index "tbl_city_distance", ["city_id", "radius", "near_city_id"], :name => "city_id_radius_near_city_id_index"
  add_index "tbl_city_distance", ["city_id", "radius"], :name => "city_id_radius_index"

  create_table "tbl_claimed_businesses_near_city", :id => false, :force => true do |t|
    t.integer   "email_batch_id",           :null => false
    t.integer   "city_id",                  :null => false
    t.integer   "total_claimed_businesses"
    t.timestamp "created_on",               :null => false
  end

  add_index "tbl_claimed_businesses_near_city", ["email_batch_id"], :name => "fk_tbl_near_city_deals_tbl_email_batches1"

  create_table "tbl_cron_timestamp", :primary_key => "process_id", :force => true do |t|
    t.timestamp "cron_timestamp",                                :null => false
    t.string    "status",         :limit => 0,  :default => "f", :null => false
    t.string    "cron_type",      :limit => 20,                  :null => false
  end

  create_table "tbl_data_source_object_types", :id => false, :force => true do |t|
    t.integer   "data_source_id", :limit => 2, :null => false
    t.integer   "object_type_id", :limit => 2, :null => false
    t.timestamp "created_on",                  :null => false
  end

  create_table "tbl_data_sources", :primary_key => "data_source_id", :force => true do |t|
    t.string    "data_source_name",    :limit => 45
    t.timestamp "last_load_timestamp"
    t.timestamp "created_on",                        :null => false
  end

  create_table "tbl_database_version", :force => true do |t|
    t.timestamp "version_timestamp", :null => false
    t.string    "release_version"
    t.string    "database_version"
  end

  create_table "tbl_delete_merge_business_listings", :force => true do |t|
    t.integer   "delete_business_id",                          :null => false
    t.integer   "merge_to_business_id"
    t.string    "action",                  :limit => 0,        :null => false
    t.integer   "status_id",                                   :null => false
    t.text      "status_message"
    t.timestamp "created_on",                                  :null => false
    t.timestamp "modified_on",                                 :null => false
    t.binary    "deleted_business_backup", :limit => 16777215
  end

  add_index "tbl_delete_merge_business_listings", ["delete_business_id", "merge_to_business_id"], :name => "delete_business_id"

  create_table "tbl_delete_merge_business_listings_status", :primary_key => "status_id", :force => true do |t|
    t.string "status_id_description", :limit => 40, :null => false
  end

  create_table "tbl_deleted_businesses", :primary_key => "deleted_business_id", :force => true do |t|
    t.integer   "merge_to_business_id",      :default => 0
    t.boolean   "is_deleted_from_memcached", :default => false
    t.boolean   "is_deleted_from_index",     :default => false
    t.timestamp "created_on",                                   :null => false
    t.timestamp "modified_on",                                  :null => false
  end

  create_table "tbl_deleted_users", :force => true do |t|
    t.integer   "user_id",                                   :null => false
    t.string    "first_name",            :limit => 100,      :null => false
    t.string    "last_name",             :limit => 100,      :null => false
    t.string    "email"
    t.integer   "deleted_by_user_id"
    t.timestamp "deleted_on",                                :null => false
    t.binary    "serialized_parameters", :limit => 16777215
  end

  add_index "tbl_deleted_users", ["user_id"], :name => "user_id_index", :unique => true

  create_table "tbl_dma_cities", :primary_key => "dma_code", :force => true do |t|
    t.string  "dma_name",      :null => false
    t.integer "dma_rank",      :null => false
    t.integer "city_id",       :null => false
    t.integer "woeid",         :null => false
    t.float   "centroid_lat",  :null => false
    t.float   "centroid_long", :null => false
    t.integer "radius",        :null => false
  end

  add_index "tbl_dma_cities", ["city_id"], :name => "city_id_index", :unique => true

  create_table "tbl_email_batches", :primary_key => "email_batch_id", :force => true do |t|
    t.string    "batch_name"
    t.string    "campaign_name"
    t.timestamp "last_batch_timestamp"
    t.timestamp "start_timestamp"
    t.timestamp "end_timestamp"
    t.string    "status",               :limit => 45
    t.text      "notes"
  end

  create_table "tbl_email_communications", :primary_key => "email_communication_id", :force => true do |t|
    t.string    "source",                 :limit => 0,   :default => "invitations", :null => false
    t.integer   "from_user_id",                                                     :null => false
    t.string    "to_email_address",       :limit => 100,                            :null => false
    t.string    "from_name",                                                        :null => false
    t.string    "from_email_address",                                               :null => false
    t.string    "reply_to_email_address",                                           :null => false
    t.string    "to_name",                                                          :null => false
    t.string    "email_subject",                                                    :null => false
    t.text      "email_content_html",                                               :null => false
    t.text      "email_content_text",                                               :null => false
    t.string    "status",                 :limit => 0,   :default => "queued",      :null => false
    t.integer   "retry_count",            :limit => 1,   :default => 0,             :null => false
    t.timestamp "create_timestamp",                                                 :null => false
    t.timestamp "last_attempt_timestamp",                                           :null => false
    t.timestamp "sent_timestamp",                                                   :null => false
  end

  add_index "tbl_email_communications", ["from_user_id"], :name => "from_user_id_index"

  create_table "tbl_event_logging_codes", :primary_key => "logging_event_id", :force => true do |t|
    t.string "logging_event_name", :limit => 100, :null => false
    t.string "logging_event_code", :limit => 100
  end

  create_table "tbl_external_businesses", :primary_key => "external_business_id", :force => true do |t|
    t.string    "external_reference_id",    :limit => 50,                                   :default => "0",             :null => false
    t.integer   "business_id"
    t.string    "business_name",                                                                                         :null => false
    t.string    "business_type",                                                                                         :null => false
    t.string    "street"
    t.string    "city"
    t.string    "state"
    t.string    "country"
    t.string    "zip_code",                 :limit => 10,                                   :default => "0"
    t.float     "latitude",                                                                 :default => 0.0
    t.float     "longitude",                                                                :default => 0.0
    t.string    "business_phone",           :limit => 20
    t.string    "website"
    t.string    "external_page_url"
    t.string    "image_url"
    t.integer   "fan_count",                                                                :default => 0
    t.integer   "not_a_business",           :limit => 1,                                    :default => 0,               :null => false
    t.timestamp "created_on",                                                                                            :null => false
    t.timestamp "modified_on",                                                                                           :null => false
    t.decimal   "match_score",                              :precision => 5,  :scale => 2
    t.string    "match_status",             :limit => 0,                                    :default => "not_processed", :null => false
    t.string    "reviewer_name"
    t.string    "reviewer_comments",        :limit => 1024
    t.integer   "imported_from_snp_id"
    t.boolean   "categorized_flag",                                                         :default => false,           :null => false
    t.boolean   "blocked_flag",                                                             :default => false,           :null => false
    t.integer   "data_source_id",           :limit => 2,                                    :default => 5,               :null => false
    t.string    "factual_id",               :limit => 36
    t.string    "factual_name"
    t.string    "factual_address",          :limit => 100
    t.string    "factual_address_extended", :limit => 100
    t.string    "factual_po_box",           :limit => 50
    t.string    "factual_locality",         :limit => 100
    t.string    "factual_region",           :limit => 50
    t.string    "factual_country",          :limit => 50
    t.string    "factual_postcode",         :limit => 50
    t.string    "factual_tel",              :limit => 50
    t.string    "factual_fax",              :limit => 50
    t.string    "factual_category"
    t.string    "factual_website",          :limit => 1024
    t.string    "factual_email"
    t.decimal   "factual_latitude",                         :precision => 18, :scale => 12
    t.decimal   "factual_longitude",                        :precision => 18, :scale => 12
    t.string    "factual_status",           :limit => 10
    t.boolean   "factual_exists_flag"
  end

  add_index "tbl_external_businesses", ["business_id"], :name => "business_id_idx"
  add_index "tbl_external_businesses", ["data_source_id", "external_reference_id", "business_id", "factual_id"], :name => "data_source_external_reference_factual_business_idx", :unique => true
  add_index "tbl_external_businesses", ["data_source_id", "match_status"], :name => "data_source_id_match_status_idx"
  add_index "tbl_external_businesses", ["factual_id"], :name => "factual_id_idx"

  create_table "tbl_external_categories", :force => true do |t|
    t.string    "external_category",    :limit => 100,                :null => false
    t.string    "external_subcategory", :limit => 100
    t.integer   "business_type_id",                                   :null => false
    t.timestamp "created_on",                                         :null => false
    t.timestamp "modified_on",                                        :null => false
    t.integer   "data_source_id",       :limit => 2,   :default => 5, :null => false
  end

  add_index "tbl_external_categories", ["business_type_id"], :name => "business_type_id_index"
  add_index "tbl_external_categories", ["created_on"], :name => "idx_created_on"
  add_index "tbl_external_categories", ["data_source_id", "external_category", "external_subcategory", "business_type_id"], :name => "udx_data_source_id_ext_category_business_type_id", :unique => true
  add_index "tbl_external_categories", ["modified_on"], :name => "idx_modified_on"

  create_table "tbl_external_categories3", :force => true do |t|
    t.string    "external_category",    :limit => 100,                :null => false
    t.string    "external_subcategory", :limit => 100
    t.integer   "business_type_id",                                   :null => false
    t.integer   "wand_node_id"
    t.timestamp "created_on",                                         :null => false
    t.timestamp "modified_on",                                        :null => false
    t.integer   "data_source_id",       :limit => 2,   :default => 5, :null => false
  end

  add_index "tbl_external_categories3", ["business_type_id"], :name => "business_type_id_index"
  add_index "tbl_external_categories3", ["created_on"], :name => "idx_created_on"
  add_index "tbl_external_categories3", ["data_source_id", "external_category", "external_subcategory", "business_type_id"], :name => "udx_data_source_id_ext_category_business_type_id", :unique => true
  add_index "tbl_external_categories3", ["modified_on"], :name => "idx_modified_on"

  create_table "tbl_external_likes", :force => true do |t|
    t.string    "external_reference_id", :limit => 50, :default => "0", :null => false
    t.string    "external_user_id",      :limit => 50, :default => "0", :null => false
    t.integer   "user_id"
    t.text      "comment"
    t.timestamp "created_on",                                           :null => false
    t.timestamp "modified_on",                                          :null => false
    t.integer   "imported_from_snp_id"
    t.integer   "unliked_flag",          :limit => 1,  :default => 0,   :null => false
    t.integer   "data_source_id",        :limit => 2,  :default => 5,   :null => false
  end

  add_index "tbl_external_likes", ["created_on", "user_id", "data_source_id"], :name => "idx_created_on_user_id_data_source"
  add_index "tbl_external_likes", ["external_reference_id", "data_source_id"], :name => "idx_ext_reference_data_source"
  add_index "tbl_external_likes", ["external_reference_id", "external_user_id", "data_source_id"], :name => "udx_ext_reference_ext_user_id_data_source", :unique => true
  add_index "tbl_external_likes", ["external_reference_id"], :name => "external_reference_id_index"
  add_index "tbl_external_likes", ["external_user_id", "user_id", "data_source_id"], :name => "idx_ext_user_id_user_id_data_source"
  add_index "tbl_external_likes", ["external_user_id"], :name => "external_user_id_index"
  add_index "tbl_external_likes", ["user_id"], :name => "user_id_index"

  create_table "tbl_external_offers", :force => true do |t|
    t.timestamp "load_timestamp",                                     :null => false
    t.string    "external_reference_id", :limit => 50,                :null => false
    t.string    "business_name"
    t.string    "business_address"
    t.string    "business_city"
    t.string    "business_state",        :limit => 2
    t.string    "business_zip",          :limit => 10
    t.string    "business_phone",        :limit => 20
    t.string    "offer_url"
    t.string    "offer_message"
    t.string    "offer_title"
    t.integer   "data_source_id",        :limit => 2,  :default => 5, :null => false
  end

  add_index "tbl_external_offers", ["data_source_id"], :name => "data_source_idx"
  add_index "tbl_external_offers", ["external_reference_id"], :name => "fk_tbl_external_offers_tbl_external_businesses1"

  create_table "tbl_external_offers_history", :primary_key => "history_id", :force => true do |t|
    t.timestamp "history_ts",                                                 :null => false
    t.string    "history_reason",        :limit => 0,  :default => "deleted", :null => false
    t.integer   "id",                                                         :null => false
    t.timestamp "load_timestamp",                                             :null => false
    t.string    "external_reference_id", :limit => 50,                        :null => false
    t.string    "business_name"
    t.string    "business_address"
    t.string    "business_city"
    t.string    "business_state",        :limit => 2
    t.string    "business_zip",          :limit => 10
    t.string    "business_phone",        :limit => 20
    t.string    "offer_url"
    t.string    "offer_message"
    t.string    "offer_title"
    t.integer   "data_source_id",        :limit => 2,  :default => 5,         :null => false
  end

  add_index "tbl_external_offers_history", ["external_reference_id"], :name => "fk_tbl_external_offers_history_tbl_external_businesses1"

  create_table "tbl_external_page_admins", :force => true do |t|
    t.integer   "social_network_profile_id"
    t.string    "external_reference_id",     :limit => 50, :default => "0",        :null => false
    t.string    "external_page_url"
    t.string    "external_reference_target", :limit => 0,  :default => "facebook", :null => false
    t.integer   "business_id"
    t.boolean   "sync_with_sn_flag",                       :default => false,      :null => false
    t.timestamp "created_on",                                                      :null => false
    t.timestamp "modified_on",                                                     :null => false
  end

  add_index "tbl_external_page_admins", ["business_id", "external_reference_target"], :name => "business_id_target_idx", :unique => true
  add_index "tbl_external_page_admins", ["business_id"], :name => "business_id_idx"
  add_index "tbl_external_page_admins", ["social_network_profile_id"], :name => "social_network_profile_id_index"

  create_table "tbl_external_providers", :primary_key => "provider_id", :force => true do |t|
    t.string    "provider_name",                     :null => false
    t.string    "default_offer_title"
    t.string    "default_offer_text"
    t.string    "event_code",          :limit => 45
    t.timestamp "last_load_timestamp"
  end

  create_table "tbl_external_user_activities", :force => true do |t|
    t.string    "external_reference_id", :limit => 50
    t.integer   "user_id",                              :null => false
    t.integer   "data_source_id",        :limit => 2,   :null => false
    t.string    "external_activity_id",  :limit => 100, :null => false
    t.timestamp "activity_datetime"
    t.string    "activity_timezone",     :limit => 100
    t.text      "activity_comment",                     :null => false
    t.timestamp "created_on",                           :null => false
  end

  add_index "tbl_external_user_activities", ["user_id", "external_reference_id", "data_source_id"], :name => "user_id_external_reference_id_data_source_id"

  create_table "tbl_friend_list_to_be_delete", :primary_key => "friends_list_id", :force => true do |t|
    t.integer   "from_user_id",                                       :null => false
    t.integer   "to_user_id",                                         :null => false
    t.timestamp "added_on",                                           :null => false
    t.string    "friend_type",  :limit => 0, :default => "AlikeList", :null => false
    t.string    "deleted",      :limit => 0, :default => "N",         :null => false
  end

  add_index "tbl_friend_list_to_be_delete", ["added_on", "deleted", "friend_type"], :name => "added_on_deleted_index"
  add_index "tbl_friend_list_to_be_delete", ["friend_type"], :name => "friend_type_index"
  add_index "tbl_friend_list_to_be_delete", ["from_user_id", "to_user_id", "deleted"], :name => "from_user_id_to_user_id_deleted_index"
  add_index "tbl_friend_list_to_be_delete", ["from_user_id", "to_user_id"], :name => "from_user_id_to_user_id_index"
  add_index "tbl_friend_list_to_be_delete", ["from_user_id"], :name => "from_user_id_index"
  add_index "tbl_friend_list_to_be_delete", ["to_user_id"], :name => "to_user_id"

  create_table "tbl_geo_dir_log", :primary_key => "row_id", :force => true do |t|
    t.date    "log_file_date",          :null => false
    t.integer "anonymous_hits_total",   :null => false
    t.integer "anonymous_hits_success", :null => false
    t.integer "anonymous_hits_failure", :null => false
  end

  create_table "tbl_gofavo_stats", :primary_key => "statistic_id", :force => true do |t|
    t.string   "statistic_field", :limit => 0, :null => false
    t.integer  "statsitic_value", :limit => 8, :null => false
    t.datetime "updated_on",                   :null => false
  end

  add_index "tbl_gofavo_stats", ["statistic_id"], :name => "statistic_id", :unique => true
  add_index "tbl_gofavo_stats", ["statistic_id"], :name => "statistic_id_2", :unique => true

  create_table "tbl_invitations", :primary_key => "invitation_id", :force => true do |t|
    t.integer   "invitation_grp_id",                    :default => 0,         :null => false
    t.integer   "invitation_from",                                             :null => false
    t.integer   "invitation_to",                                               :null => false
    t.string    "to_email_id",                                                 :null => false
    t.string    "to_first_name"
    t.integer   "to_city_id",                                                  :null => false
    t.integer   "subject_id",                           :default => 0,         :null => false
    t.string    "subject",                                                     :null => false
    t.string    "to_last_name",                                                :null => false
    t.string    "is_to_registered",       :limit => 0,  :default => "n",       :null => false
    t.timestamp "invited_on",                                                  :null => false
    t.string    "invitation_status",      :limit => 0,  :default => "pending"
    t.string    "invitation_type",        :limit => 0
    t.timestamp "action_time",                                                 :null => false
    t.text      "invitation_message",                                          :null => false
    t.string    "inbox_status",           :limit => 0,  :default => "unread",  :null => false
    t.string    "from_first_name"
    t.string    "md5_invitation_id",      :limit => 32
    t.integer   "business_id"
    t.boolean   "is_sent_flag",                         :default => false,     :null => false
    t.integer   "email_communication_id",               :default => 0,         :null => false
  end

  add_index "tbl_invitations", ["business_id", "to_email_id"], :name => "business_id_to_email_id_index"
  add_index "tbl_invitations", ["email_communication_id"], :name => "email_communication_id_index"
  add_index "tbl_invitations", ["invitation_from"], :name => "invitation_from_index"
  add_index "tbl_invitations", ["invitation_to", "inbox_status", "invitation_status"], :name => "invitation_to_inbox_status_invitation_status_index"
  add_index "tbl_invitations", ["invitation_to", "inbox_status"], :name => "invitation_to_inbox_status_index"
  add_index "tbl_invitations", ["invitation_to"], :name => "invitation_to_index"
  add_index "tbl_invitations", ["invited_on"], :name => "invited_on_idx"
  add_index "tbl_invitations", ["md5_invitation_id"], :name => "md5_invitation_id_index"

  create_table "tbl_job_queue", :force => true do |t|
    t.integer   "social_network_profile_id"
    t.integer   "priority",                                      :default => 0,                  :null => false
    t.string    "job_status",                :limit => 0,        :default => "pending",          :null => false
    t.string    "command",                   :limit => 0,        :default => "process_get_data", :null => false
    t.string    "session_secret",            :limit => 200
    t.binary    "serialized_parameters",     :limit => 16777215
    t.timestamp "created_on",                                                                    :null => false
    t.timestamp "modified_on",                                                                   :null => false
    t.integer   "retry_count",               :limit => 2,        :default => 0
    t.text      "notes"
    t.integer   "sn_id",                     :limit => 1,        :default => 1,                  :null => false
  end

  add_index "tbl_job_queue", ["job_status", "sn_id", "command"], :name => "idx_job_status_sn_id_command"
  add_index "tbl_job_queue", ["social_network_profile_id"], :name => "social_network_profile_id_index"

  create_table "tbl_lcd_flagged_business_listings", :primary_key => "lcd_listing_flagged_id", :force => true do |t|
    t.integer   "business_id",                           :null => false
    t.integer   "user_id",                               :null => false
    t.boolean   "pushed_to_crm_flag", :default => false, :null => false
    t.timestamp "created_on",                            :null => false
    t.timestamp "modified_on",                           :null => false
  end

  add_index "tbl_lcd_flagged_business_listings", ["business_id"], :name => "business_id_index"
  add_index "tbl_lcd_flagged_business_listings", ["pushed_to_crm_flag"], :name => "pushed_to_crm_flag"
  add_index "tbl_lcd_flagged_business_listings", ["user_id"], :name => "user_id_index"

  create_table "tbl_list_items_history", :primary_key => "history_id", :force => true do |t|
    t.timestamp "history_ts",                                         :null => false
    t.string    "history_reason", :limit => 0, :default => "updated", :null => false
    t.integer   "user_id",                                            :null => false
    t.integer   "list_id",                                            :null => false
    t.integer   "item_id",                                            :null => false
  end

  add_index "tbl_list_items_history", ["item_id"], :name => "item_id_index"
  add_index "tbl_list_items_history", ["list_id"], :name => "list_id_index"
  add_index "tbl_list_items_history", ["user_id"], :name => "user_id_index"

  create_table "tbl_list_items_to_be_deleted", :id => false, :force => true do |t|
    t.integer "user_id", :null => false
    t.integer "list_id", :null => false
    t.integer "item_id", :null => false
  end

  add_index "tbl_list_items_to_be_deleted", ["item_id"], :name => "item_id_index"
  add_index "tbl_list_items_to_be_deleted", ["list_id"], :name => "list_id_index"
  add_index "tbl_list_items_to_be_deleted", ["user_id", "item_id"], :name => "user_id_item_id_index"
  add_index "tbl_list_items_to_be_deleted", ["user_id", "list_id"], :name => "user_id_list_id_index"
  add_index "tbl_list_items_to_be_deleted", ["user_id"], :name => "user_id_index"

  create_table "tbl_mail_share", :primary_key => "message_id", :force => true do |t|
    t.integer  "parent_id",                    :default => 0
    t.string   "business_name", :limit => 100,                       :null => false
    t.integer  "from_id"
    t.string   "from_name",     :limit => 20,                        :null => false
    t.integer  "to_id"
    t.string   "to_name",       :limit => 20,                        :null => false
    t.string   "subject",       :limit => 50,                        :null => false
    t.text     "message"
    t.string   "inbox_status",  :limit => 0,   :default => "unread", :null => false
    t.datetime "date_added",                                         :null => false
  end

  add_index "tbl_mail_share", ["business_name", "from_id", "to_id"], :name => "business_name"
  add_index "tbl_mail_share", ["to_id", "inbox_status"], :name => "to_id_inbox_status_index"
  add_index "tbl_mail_share", ["to_id"], :name => "to_id_index"

  create_table "tbl_mailer_log", :primary_key => "maillog_id", :force => true do |t|
    t.integer  "user_id",                                       :null => false
    t.text     "logmessage",                                    :null => false
    t.text     "email_header",                                  :null => false
    t.text     "email_body",                                    :null => false
    t.datetime "mail_sent_on",                                  :null => false
    t.string   "send_again_flag", :limit => 1, :default => "Y", :null => false
  end

  create_table "tbl_mailmsgs", :primary_key => "message_id", :force => true do |t|
    t.integer   "parent_id",                                       :null => false
    t.integer   "thread_id",                                       :null => false
    t.integer   "from_id",                                         :null => false
    t.integer   "to_id",                                           :null => false
    t.string    "subject",                                         :null => false
    t.text      "message",                                         :null => false
    t.timestamp "date_added",                                      :null => false
    t.string    "inbox_status", :limit => 0, :default => "unread", :null => false
    t.string    "message_type", :limit => 0, :default => "ask",    :null => false
    t.integer   "business_id"
  end

  add_index "tbl_mailmsgs", ["from_id"], :name => "from_id_index"
  add_index "tbl_mailmsgs", ["to_id", "from_id", "inbox_status", "thread_id"], :name => "to_id_from_id_inbox_status_thread_id_index"
  add_index "tbl_mailmsgs", ["to_id", "inbox_status"], :name => "to_id_inbox_status_index"
  add_index "tbl_mailmsgs", ["to_id"], :name => "to_id_index"

  create_table "tbl_object_types", :primary_key => "object_type_id", :force => true do |t|
    t.string    "object_type_name", :limit => 45
    t.timestamp "created_on",                     :null => false
  end

  create_table "tbl_periodicemail_city_deals", :primary_key => "periodicemail_city_deals_id", :force => true do |t|
    t.integer   "email_batch_id",               :null => false
    t.integer   "user_city_id"
    t.integer   "message_id",                   :null => false
    t.integer   "business_id",                  :null => false
    t.integer   "city_id"
    t.string    "city_name",      :limit => 50
    t.string    "state_code",     :limit => 2
    t.string    "business_name"
    t.string    "website"
    t.string    "message_type",   :limit => 0
    t.string    "offer_url"
    t.timestamp "created_on",                   :null => false
    t.integer   "data_source_id", :limit => 2
  end

  add_index "tbl_periodicemail_city_deals", ["email_batch_id", "user_city_id"], :name => "idx_email_batch_id_user_city_id"

  create_table "tbl_periodicemail_claimed_businesses", :primary_key => "periodicemail_claimed_businesses_id", :force => true do |t|
    t.integer   "email_batch_id",                 :null => false
    t.integer   "city_id"
    t.integer   "business_id"
    t.string    "business_name"
    t.timestamp "activation_date"
    t.string    "image_file_path", :limit => 150
    t.timestamp "created_on",                     :null => false
  end

  add_index "tbl_periodicemail_claimed_businesses", ["email_batch_id", "city_id"], :name => "idx_email_batch_id_city_id"
  add_index "tbl_periodicemail_claimed_businesses", ["email_batch_id"], :name => "fk_tbl_periodicemail_claimed_businesses_tbl_email_batches1"

  create_table "tbl_periodicemail_execution_log", :id => false, :force => true do |t|
    t.string    "sp_name",        :limit => 50
    t.string    "statement",      :limit => 1024
    t.timestamp "execution_time",                 :null => false
  end

  create_table "tbl_periodicemail_friends_liked", :primary_key => "periodicemail_friends_liked_id", :force => true do |t|
    t.integer   "user_periodicemail_id",                :null => false
    t.integer   "user_id",                              :null => false
    t.integer   "friend_user_id"
    t.string    "friend_first_name",     :limit => 100
    t.string    "friend_last_name",      :limit => 100
    t.string    "profile_photo_path",    :limit => 150
    t.timestamp "created_on",                           :null => false
  end

  add_index "tbl_periodicemail_friends_liked", ["user_periodicemail_id"], :name => "fk_tbl_periodicemail_friends_liked_tbl_user_periodicemail1"

  create_table "tbl_periodicemail_special_users", :id => false, :force => true do |t|
    t.integer   "email_batch_id", :null => false
    t.integer   "user_id",        :null => false
    t.timestamp "created_on",     :null => false
  end

  create_table "tbl_periodicemail_user_status", :primary_key => "user_id", :force => true do |t|
    t.integer   "noactivity_email_sent_flag", :limit => 1, :null => false
    t.integer   "status_email_batch_id",                   :null => false
    t.timestamp "created_on",                              :null => false
    t.timestamp "modified_on",                             :null => false
  end

  create_table "tbl_possible_activities", :force => true do |t|
    t.string "activity",                               :null => false
    t.string "show",     :limit => 0, :default => "Y", :null => false
  end

  create_table "tbl_rpt_calendar", :id => false, :force => true do |t|
    t.date "calendar_date", :null => false
  end

  create_table "tbl_rpt_daily_kpi", :primary_key => "calendar_date", :force => true do |t|
    t.integer "registered_users",                 :default => 0, :null => false
    t.integer "claimed_bls",                      :default => 0, :null => false
    t.integer "bls_with_messages_offers",         :default => 0, :null => false
    t.integer "bls_with_active_smb_offers",       :default => 0, :null => false
    t.integer "bls_with_active_3rd_party_offers", :default => 0, :null => false
    t.integer "bls_with_comments",                :default => 0, :null => false
    t.integer "bls_received_new_comments",        :default => 0, :null => false
    t.integer "total_comments",                   :default => 0, :null => false
    t.integer "likelist_likes",                   :default => 0, :null => false
    t.integer "external_likes",                   :default => 0, :null => false
    t.integer "off_fb_external_likes",            :default => 0, :null => false
    t.integer "total_likes",                      :default => 0, :null => false
    t.integer "likes_from_new_joins",             :default => 0, :null => false
    t.integer "likes_from_new_sn_users",          :default => 0, :null => false
  end

  create_table "tbl_rpt_execution_log", :force => true do |t|
    t.string   "sp_name",        :limit => 50
    t.string   "statement",      :limit => 1024
    t.datetime "execution_time"
  end

  create_table "tbl_rpt_monthly_kpi", :primary_key => "calendar_month", :force => true do |t|
    t.integer "registered_users",                 :default => 0, :null => false
    t.integer "claimed_bls",                      :default => 0, :null => false
    t.integer "bls_with_messages_offers",         :default => 0, :null => false
    t.integer "bls_with_active_smb_offers",       :default => 0, :null => false
    t.integer "bls_with_active_3rd_party_offers", :default => 0, :null => false
    t.integer "bls_with_comments",                :default => 0, :null => false
    t.integer "bls_received_new_comments",        :default => 0, :null => false
    t.integer "total_comments",                   :default => 0, :null => false
    t.integer "likelist_likes",                   :default => 0, :null => false
    t.integer "external_likes",                   :default => 0, :null => false
    t.integer "off_fb_external_likes",            :default => 0, :null => false
    t.integer "total_likes",                      :default => 0, :null => false
    t.integer "likes_from_new_joins",             :default => 0, :null => false
    t.integer "likes_from_new_sn_users",          :default => 0, :null => false
  end

  create_table "tbl_rpt_staging_business_rating", :force => true do |t|
    t.integer   "businesses_id",                 :null => false
    t.integer   "user_list_id",                  :null => false
    t.string    "has_comment_flag", :limit => 1, :null => false
    t.string    "list_type",        :limit => 0, :null => false
    t.timestamp "rated_on",                      :null => false
    t.timestamp "modified_on",                   :null => false
    t.integer   "city_id",                       :null => false
    t.integer   "sn_id",            :limit => 1, :null => false
  end

  create_table "tbl_rpt_staging_business_rating_backup", :force => true do |t|
    t.integer   "businesses_id",                 :null => false
    t.integer   "user_list_id",                  :null => false
    t.string    "has_comment_flag", :limit => 1, :null => false
    t.string    "list_type",        :limit => 0, :null => false
    t.timestamp "rated_on",                      :null => false
    t.timestamp "modified_on",                   :null => false
    t.string    "is_deleted",       :limit => 0, :null => false
    t.integer   "city_id",                       :null => false
  end

  create_table "tbl_rpt_staging_promo_messages", :primary_key => "message_id", :force => true do |t|
    t.integer   "business_id",                         :null => false
    t.string    "has_valid_message_flag", :limit => 1, :null => false
    t.string    "message_type",           :limit => 0, :null => false
    t.timestamp "start_timestamp",                     :null => false
    t.timestamp "end_timestamp",                       :null => false
    t.integer   "impression_count",                    :null => false
    t.integer   "click_thru_count",                    :null => false
    t.timestamp "created_on",                          :null => false
    t.timestamp "modified_on",                         :null => false
  end

  create_table "tbl_rpt_zlikes_per_city", :id => false, :force => true do |t|
    t.string  "city"
    t.string  "state",                            :limit => 2
    t.integer "likes"
    t.integer "unique_likes"
    t.integer "registered_users"
    t.integer "stub_users"
    t.integer "claimed_bls"
    t.integer "claimed_BLs_with_Messages_Offers"
  end

  create_table "tbl_search_records", :force => true do |t|
    t.integer "search_id", :null => false
    t.text    "resultset"
  end

  create_table "tbl_state", :primary_key => "state_id", :force => true do |t|
    t.string "state_name", :limit => 128
    t.string "state_code", :limit => 2
  end

  add_index "tbl_state", ["state_code"], :name => "state_code"
  add_index "tbl_state", ["state_code"], :name => "state_code_2"

  create_table "tbl_subject", :primary_key => "subject_id", :force => true do |t|
    t.string "subject",  :null => false
    t.text   "template", :null => false
  end

  create_table "tbl_supressed_emails", :primary_key => "supress_id", :force => true do |t|
    t.string    "email_address", :limit => 60, :null => false
    t.timestamp "created_on",                  :null => false
  end

  add_index "tbl_supressed_emails", ["email_address"], :name => "email_address_index"

  create_table "tbl_ugc_businesses", :primary_key => "business_id", :force => true do |t|
    t.string    "business_name",                                           :null => false
    t.integer   "business_type_id",                       :default => 0,   :null => false
    t.integer   "business_user_id",         :limit => 8,  :default => 0,   :null => false
    t.string    "address1"
    t.string    "address2"
    t.integer   "city_id",                                :default => 0,   :null => false
    t.string    "state_code",               :limit => 2
    t.string    "zip_code",                 :limit => 10, :default => "0"
    t.string    "business_phone",           :limit => 20
    t.string    "business_secondary_phone", :limit => 20
    t.string    "business_tertiary_phone",  :limit => 20
    t.string    "website"
    t.string    "business_info"
    t.float     "latitude",                               :default => 0.0
    t.float     "longitude",                              :default => 0.0
    t.timestamp "created_on",                                              :null => false
    t.timestamp "modified_on",                                             :null => false
    t.string    "is_deleted",               :limit => 0,  :default => "N"
    t.string    "city"
    t.string    "is_rated",                 :limit => 1,  :default => "N"
    t.string    "source_external_id",       :limit => 50, :default => "0", :null => false
    t.string    "user_entered_category"
  end

  add_index "tbl_ugc_businesses", ["business_info"], :name => "business_phone_index"
  add_index "tbl_ugc_businesses", ["city_id"], :name => "city_id_index"
  add_index "tbl_ugc_businesses", ["latitude"], :name => "latitude_index"
  add_index "tbl_ugc_businesses", ["longitude"], :name => "longitude_index"
  add_index "tbl_ugc_businesses", ["source_external_id"], :name => "source_external_index"
  add_index "tbl_ugc_businesses", ["state_code"], :name => "state_code_index"
  add_index "tbl_ugc_businesses", ["zip_code"], :name => "zip_code_index"

  create_table "tbl_user_attributes_to_be_deleted", :id => false, :force => true do |t|
    t.integer "user_id",                :null => false
    t.integer "the_key",   :limit => 1, :null => false
    t.string  "the_value"
  end

  add_index "tbl_user_attributes_to_be_deleted", ["user_id", "the_key"], :name => "user_id_the_key_index"
  add_index "tbl_user_attributes_to_be_deleted", ["user_id"], :name => "user_id_index"

  create_table "tbl_user_lists_to_be_deleted", :primary_key => "list_id", :force => true do |t|
    t.integer   "user_id",                                                :null => false
    t.string    "list_name",     :limit => 32,                            :null => false
    t.string    "list_notes"
    t.string    "is_shared",     :limit => 1,  :default => "N",           :null => false
    t.string    "privacy_state", :limit => 0,  :default => "friendsonly", :null => false
    t.timestamp "created_on",                                             :null => false
    t.timestamp "modified_on",                                            :null => false
  end

  add_index "tbl_user_lists_to_be_deleted", ["user_id", "list_name"], :name => "user_id_list_name_index", :unique => true
  add_index "tbl_user_lists_to_be_deleted", ["user_id"], :name => "user_id_index"

  create_table "tbl_user_locations", :id => false, :force => true do |t|
    t.integer "user_id", :null => false
    t.integer "city_id", :null => false
    t.integer "radius",  :null => false
  end

  create_table "tbl_user_periodicemail", :primary_key => "user_periodicemail_id", :force => true do |t|
    t.integer   "email_batch_id",                                                              :null => false
    t.integer   "user_id",                                                                     :null => false
    t.string    "email"
    t.string    "first_name",                                 :limit => 40
    t.string    "last_name",                                  :limit => 40
    t.integer   "city_id"
    t.integer   "total_friends_liked_recently",                             :default => 0
    t.integer   "total_businesses_liked_by_friends_recently",               :default => 0
    t.integer   "total_friends_liked",                                      :default => 0
    t.integer   "total_businesses_liked",                                   :default => 0
    t.integer   "total_businesses_activated_nearby_recently",               :default => 0
    t.integer   "total_deals_on_userlists",                                 :default => 0
    t.boolean   "has_local_deals_flag",                                     :default => false, :null => false
    t.string    "city_name",                                  :limit => 50
    t.string    "state_code",                                 :limit => 2
    t.string    "status",                                     :limit => 45
    t.timestamp "created_on",                                                                  :null => false
    t.timestamp "modified_on",                                                                 :null => false
    t.text      "serialized_parameters"
  end

  add_index "tbl_user_periodicemail", ["email_batch_id", "city_id", "has_local_deals_flag"], :name => "idx_email_batch_city_id_has_local_deals_flag"
  add_index "tbl_user_periodicemail", ["email_batch_id", "has_local_deals_flag", "city_id"], :name => "idx_email_batch_id_has_local_deals_flag_city_id"
  add_index "tbl_user_periodicemail", ["email_batch_id", "status", "city_id"], :name => "idx_user_periodicemail_batch_status_city_id"
  add_index "tbl_user_periodicemail", ["email_batch_id", "user_id", "city_id"], :name => "idx_user_periodicemail_batch_user_city_id"
  add_index "tbl_user_periodicemail", ["email_batch_id"], :name => "fk_tbl_user_periodicemail_tbl_email_batches1"
  add_index "tbl_user_periodicemail", ["user_id"], :name => "fk_tbl_user_periodicemail_tbl_users1"

  create_table "tbl_user_periodicemail_deals", :primary_key => "user_periodicemail_deals_id", :force => true do |t|
    t.integer   "user_periodicemail_id",                :null => false
    t.integer   "message_id",                           :null => false
    t.integer   "user_id",                              :null => false
    t.integer   "email_batch_id"
    t.integer   "business_id",                          :null => false
    t.string    "deal_list_type",        :limit => 0
    t.integer   "city_id"
    t.string    "city_name",             :limit => 50
    t.string    "state_code",            :limit => 2
    t.string    "business_name"
    t.string    "business_phone",        :limit => 20
    t.string    "image_file_path",       :limit => 150
    t.string    "website"
    t.string    "message_title"
    t.string    "one_min_message"
    t.timestamp "start_timestamp"
    t.timestamp "end_timestamp"
    t.string    "message_type",          :limit => 0
    t.string    "offer_url"
    t.timestamp "created_on",                           :null => false
    t.integer   "data_source_id",        :limit => 2
  end

  add_index "tbl_user_periodicemail_deals", ["user_id"], :name => "fk_tbl_user_periodicemail_deals_tbl_users1"
  add_index "tbl_user_periodicemail_deals", ["user_periodicemail_id", "message_id"], :name => "idx_user_periodicemail_message_id"

  create_table "tbl_users_smb_notify", :force => true do |t|
    t.integer "business_id",                                    :null => false
    t.string  "ugc_business",   :limit => 0,   :default => "N", :null => false
    t.integer "user_id",                       :default => 0,   :null => false
    t.string  "email_address",  :limit => 100,                  :null => false
    t.string  "notify_me",      :limit => 0,   :default => "N", :null => false
    t.string  "is_legal_owner", :limit => 0,   :default => "N", :null => false
  end

  add_index "tbl_users_smb_notify", ["business_id"], :name => "business_id_index"
  add_index "tbl_users_smb_notify", ["user_id"], :name => "user_id_index"

  create_table "tbl_users_smb_notify_history", :primary_key => "history_id", :force => true do |t|
    t.timestamp "history_ts",                                                 :null => false
    t.string    "history_reason",       :limit => 0,   :default => "updated", :null => false
    t.integer   "id",                                                         :null => false
    t.integer   "business_id",                                                :null => false
    t.string    "ugc_business",         :limit => 0,   :default => "N",       :null => false
    t.integer   "user_id",                             :default => 0,         :null => false
    t.string    "email_address",        :limit => 100,                        :null => false
    t.string    "notify_me",            :limit => 0,   :default => "N",       :null => false
    t.string    "is_legal_owner",       :limit => 0,   :default => "N",       :null => false
    t.integer   "merge_to_business_id",                :default => 0,         :null => false
  end

  add_index "tbl_users_smb_notify_history", ["business_id"], :name => "business_id_index"
  add_index "tbl_users_smb_notify_history", ["user_id"], :name => "user_id_index"

  create_table "tbl_users_to_be_deleted", :primary_key => "user_id", :force => true do |t|
    t.string    "password",           :limit => 50,                              :null => false
    t.string    "user_level",         :limit => 0,   :default => "user",         :null => false
    t.string    "first_name",         :limit => 100,                             :null => false
    t.string    "last_name",          :limit => 100,                             :null => false
    t.string    "address1"
    t.string    "address2"
    t.integer   "city_id",                                                       :null => false
    t.string    "state",              :limit => 2
    t.string    "zip_code",           :limit => 10
    t.timestamp "created_on",                                                    :null => false
    t.timestamp "modified_on",                                                   :null => false
    t.timestamp "last_login_on",                                                 :null => false
    t.timestamp "login_on",                                                      :null => false
    t.string    "activation_code",    :limit => 150,                             :null => false
    t.string    "profile_status",     :limit => 0,   :default => "inactive",     :null => false
    t.text      "user_info",                                                     :null => false
    t.string    "profile_photo_path",                                            :null => false
    t.text      "hobbies",                                                       :null => false
    t.text      "places",                                                        :null => false
    t.text      "things",                                                        :null => false
    t.string    "source",             :limit => 0,   :default => "registration", :null => false
    t.string    "city_name",          :limit => 50
    t.integer   "preferred_sn_id",    :limit => 1,   :default => 0,              :null => false
    t.boolean   "stub_flag",                         :default => false,          :null => false
    t.integer   "data_source_id",     :limit => 2,   :default => 0,              :null => false
  end

  add_index "tbl_users_to_be_deleted", ["city_id"], :name => "city_id_index"
  add_index "tbl_users_to_be_deleted", ["created_on", "stub_flag"], :name => "created_on_stub_flag_idx"
  add_index "tbl_users_to_be_deleted", ["first_name"], :name => "first_name_idx"
  add_index "tbl_users_to_be_deleted", ["last_name"], :name => "last_name_idx"
  add_index "tbl_users_to_be_deleted", ["profile_status"], :name => "login_name_profile_status_index"

  create_table "tbl_users_to_be_processed", :force => true do |t|
    t.integer   "user_id",                                                                :null => false
    t.integer   "merged_to_user_id"
    t.string    "process_type",              :limit => 0,                                 :null => false
    t.timestamp "process_start_timestamp"
    t.string    "process_status",            :limit => 20,   :default => "not processed", :null => false
    t.string    "last_step_name",            :limit => 50
    t.timestamp "last_step_start_timestamp"
    t.timestamp "last_step_end_timestamp"
    t.string    "last_step_status",          :limit => 50,   :default => "started"
    t.string    "notes",                     :limit => 1024
  end

  create_table "tbl_view_business_log", :primary_key => "view_id", :force => true do |t|
    t.integer   "business_id", :null => false
    t.integer   "user_id",     :null => false
    t.integer   "view_count",  :null => false
    t.timestamp "view_date",   :null => false
  end

  create_table "tbl_view_business_phone_log", :primary_key => "view_id", :force => true do |t|
    t.integer   "business_id", :null => false
    t.integer   "view_count",  :null => false
    t.timestamp "view_date",   :null => false
  end

  create_table "tbl_zip_code_to_be_deleted", :id => false, :force => true do |t|
    t.string  "zip_code",   :limit => 5,  :null => false
    t.string  "city_name",                :null => false
    t.integer "city_id",                  :null => false
    t.string  "state_code", :limit => 20, :null => false
    t.float   "latitude",                 :null => false
    t.float   "longitude",                :null => false
    t.string  "country",    :limit => 50, :null => false
  end

  add_index "tbl_zip_code_to_be_deleted", ["city_id"], :name => "city_id"
  add_index "tbl_zip_code_to_be_deleted", ["city_name", "state_code"], :name => "city_name_state_code_index"
  add_index "tbl_zip_code_to_be_deleted", ["latitude"], :name => "latitude"
  add_index "tbl_zip_code_to_be_deleted", ["longitude"], :name => "longitude"
  add_index "tbl_zip_code_to_be_deleted", ["state_code"], :name => "state_code_index"
  add_index "tbl_zip_code_to_be_deleted", ["zip_code"], :name => "zip_code_index"

  create_table "tmp_friends2", :id => false, :force => true do |t|
    t.integer "user_id"
  end

  create_table "tmp_staging_import_SVVB", :id => false, :force => true do |t|
    t.string "newbiz_ind",         :limit => 1
    t.string "business_name"
    t.string "address1"
    t.string "city"
    t.string "state_code",         :limit => 2
    t.string "zip_code",           :limit => 10
    t.string "business_phone",     :limit => 20
    t.string "website"
    t.string "business_info"
    t.string "category_name"
    t.string "business_id",        :limit => 20
    t.string "business_type_id",   :limit => 20
    t.float  "latitude",                         :default => 0.0
    t.float  "longitude",                        :default => 0.0
    t.string "category_id",        :limit => 20
    t.string "city_id",            :limit => 20
    t.string "source_external_id", :limit => 50
  end

  create_table "toplist_business_types", :id => false, :force => true do |t|
    t.integer   "business_type_id",                    :null => false
    t.integer   "city_id",                             :null => false
    t.boolean   "is_deleted_flag",  :default => false, :null => false
    t.string    "image_file_path"
    t.timestamp "created_at",                          :null => false
    t.timestamp "updated_at",                          :null => false
  end

  add_index "toplist_business_types", ["business_type_id"], :name => "fk_toplist_business_types_tbl_business_types1"

  create_table "transaction_terms", :force => true do |t|
    t.text      "terms",                :limit => 16777215
    t.timestamp "effective_start_date",                     :null => false
    t.timestamp "effective_end_date",                       :null => false
    t.timestamp "created_at",                               :null => false
    t.timestamp "updated_at",                               :null => false
  end

  create_table "user_purchases", :force => true do |t|
    t.integer   "user_id",                                                                            :null => false
    t.timestamp "purchase_date"
    t.string    "purchase_status", :limit => 0,                                                       :null => false
    t.decimal   "amount",                              :precision => 10, :scale => 2
    t.string    "buyer_email",                                                        :default => "", :null => false
    t.text      "receipt",         :limit => 16777215
    t.timestamp "created_at",                                                                         :null => false
    t.timestamp "updated_at",                                                                         :null => false
  end

  create_table "user_relationships", :force => true do |t|
    t.integer   "from_user_id",                                              :null => false
    t.integer   "to_user_id",                                                :null => false
    t.string    "relationship_status", :limit => 0, :default => "following", :null => false
    t.timestamp "created_at",                                                :null => false
    t.timestamp "updated_at",                                                :null => false
  end

  add_index "user_relationships", ["from_user_id", "to_user_id"], :name => "from_user_id_to_user_id_index", :unique => true
  add_index "user_relationships", ["from_user_id"], :name => "from_user_id_index"
  add_index "user_relationships", ["to_user_id"], :name => "to_user_id_index"

  create_table "user_stats_summary", :id => false, :force => true do |t|
    t.integer   "user_id"
    t.string    "login_name",       :limit => 100
    t.string    "first_name",       :limit => 100
    t.string    "last_name",        :limit => 100
    t.string    "email_id",         :limit => 100
    t.timestamp "created_on",                                     :null => false
    t.string    "profile_status",   :limit => 0
    t.string    "source",           :limit => 0
    t.integer   "friends_count"
    t.integer   "likelist_count"
    t.timestamp "last_modified",                                  :null => false
    t.integer   "invitation_count",                :default => 0
  end

  add_index "user_stats_summary", ["user_id"], :name => "user_id_index", :unique => true

  create_table "users", :force => true do |t|
    t.string    "password",                 :limit => 50,       :default => "",             :null => false
    t.string    "user_level",               :limit => 0,        :default => "user",         :null => false
    t.string    "first_name",               :limit => 100,      :default => "",             :null => false
    t.string    "last_name",                :limit => 100,      :default => "",             :null => false
    t.integer   "location_id"
    t.integer   "postal_code_id"
    t.text      "preferences",              :limit => 16777215,                             :null => false
    t.integer   "marketing_emails_flag",    :limit => 1,        :default => 1,              :null => false
    t.integer   "user_communications_flag", :limit => 1,        :default => 1,              :null => false
    t.integer   "periodic_news_deals_flag", :limit => 1,        :default => 1,              :null => false
    t.integer   "coupon_emails_flag",       :limit => 1,        :default => 1,              :null => false
    t.timestamp "created_at",                                                               :null => false
    t.timestamp "updated_at",                                                               :null => false
    t.timestamp "last_login_on",                                                            :null => false
    t.timestamp "login_on",                                                                 :null => false
    t.string    "activation_code",          :limit => 150,      :default => "",             :null => false
    t.string    "profile_status",           :limit => 0,        :default => "inactive",     :null => false
    t.text      "user_info",                                                                :null => false
    t.string    "profile_photo_path",                           :default => "",             :null => false
    t.text      "hobbies",                                                                  :null => false
    t.text      "places",                                                                   :null => false
    t.text      "things",                                                                   :null => false
    t.string    "source",                   :limit => 0,        :default => "registration", :null => false
    t.integer   "preferred_sn_id",          :limit => 1,        :default => 0,              :null => false
    t.boolean   "stub_flag",                                    :default => false,          :null => false
    t.integer   "data_source_id",           :limit => 2,        :default => 0,              :null => false
    t.string    "encrypted_password",       :limit => 128,      :default => "",             :null => false
    t.string    "password_salt"
    t.string    "reset_password_token"
    t.string    "remember_token"
    t.timestamp "remember_created_at",                                                      :null => false
    t.integer   "sign_in_count",                                :default => 0
    t.timestamp "current_sign_in_at",                                                       :null => false
    t.timestamp "last_sign_in_at",                                                          :null => false
    t.string    "current_sign_in_ip",       :limit => 15
    t.string    "last_sign_in_ip",          :limit => 15
    t.string    "vanity_name",              :limit => 100
    t.string    "website"
    t.string    "website_name"
    t.string    "facebook_link"
    t.string    "twitter_link"
    t.string    "gowalla_link"
    t.string    "foursquare_link"
    t.string    "youtube_link"
    t.string    "tumblr_link"
  end

  add_index "users", ["first_name", "profile_status", "preferred_sn_id", "last_name"], :name => "lnames_preferred_sn_id_status2"
  add_index "users", ["last_name", "profile_status", "preferred_sn_id", "first_name"], :name => "lnames_preferred_sn_id_status1"
  add_index "users", ["location_id"], :name => "location_id_idx"
  add_index "users", ["vanity_name"], :name => "unx_vanity_name", :unique => true

  create_table "web_pages", :force => true do |t|
    t.string    "page_name",  :limit => 50, :null => false
    t.timestamp "created_at",               :null => false
  end

  create_table "wp_commentmeta", :primary_key => "meta_id", :force => true do |t|
    t.integer "comment_id", :limit => 8,          :default => 0, :null => false
    t.string  "meta_key"
    t.text    "meta_value", :limit => 2147483647
  end

  add_index "wp_commentmeta", ["comment_id"], :name => "comment_id"
  add_index "wp_commentmeta", ["meta_key"], :name => "meta_key"

  create_table "wp_comments", :primary_key => "comment_ID", :force => true do |t|
    t.integer  "comment_post_ID",      :limit => 8,   :default => 0,   :null => false
    t.text     "comment_author",       :limit => 255,                  :null => false
    t.string   "comment_author_email", :limit => 100, :default => "",  :null => false
    t.string   "comment_author_url",   :limit => 200, :default => "",  :null => false
    t.string   "comment_author_IP",    :limit => 100, :default => "",  :null => false
    t.datetime "comment_date",                                         :null => false
    t.datetime "comment_date_gmt",                                     :null => false
    t.text     "comment_content",                                      :null => false
    t.integer  "comment_karma",                       :default => 0,   :null => false
    t.string   "comment_approved",     :limit => 20,  :default => "1", :null => false
    t.string   "comment_agent",                       :default => "",  :null => false
    t.string   "comment_type",         :limit => 20,  :default => "",  :null => false
    t.integer  "comment_parent",       :limit => 8,   :default => 0,   :null => false
    t.integer  "user_id",              :limit => 8,   :default => 0,   :null => false
  end

  add_index "wp_comments", ["comment_approved", "comment_date_gmt"], :name => "comment_approved_date_gmt"
  add_index "wp_comments", ["comment_approved"], :name => "comment_approved"
  add_index "wp_comments", ["comment_date_gmt"], :name => "comment_date_gmt"
  add_index "wp_comments", ["comment_parent"], :name => "comment_parent"
  add_index "wp_comments", ["comment_post_ID"], :name => "comment_post_ID"

  create_table "wp_download_monitor_file_meta", :force => true do |t|
    t.text    "meta_name",   :limit => 2147483647, :null => false
    t.text    "meta_value",  :limit => 2147483647, :null => false
    t.integer "download_id",                       :null => false
  end

  create_table "wp_download_monitor_files", :force => true do |t|
    t.string   "title",            :limit => 200,        :null => false
    t.text     "filename",         :limit => 2147483647, :null => false
    t.text     "file_description", :limit => 2147483647
    t.string   "dlversion",        :limit => 200,        :null => false
    t.datetime "postDate",                               :null => false
    t.integer  "hits",                                   :null => false
    t.string   "user",             :limit => 200,        :null => false
    t.integer  "members"
    t.text     "mirrors",          :limit => 2147483647
  end

  create_table "wp_download_monitor_formats", :force => true do |t|
    t.string "name",   :limit => 250,        :null => false
    t.text   "format", :limit => 2147483647, :null => false
  end

  create_table "wp_download_monitor_log", :force => true do |t|
    t.integer  "download_id",                :null => false
    t.integer  "user_id",                    :null => false
    t.datetime "date"
    t.string   "ip_address",  :limit => 200
  end

  create_table "wp_download_monitor_relationships", :force => true do |t|
    t.integer "taxonomy_id", :null => false
    t.integer "download_id", :null => false
  end

  create_table "wp_download_monitor_stats", :force => true do |t|
    t.integer "download_id", :null => false
    t.date    "date",        :null => false
    t.integer "hits",        :null => false
  end

  create_table "wp_download_monitor_taxonomies", :force => true do |t|
    t.text    "name",     :limit => 2147483647, :null => false
    t.integer "parent",                         :null => false
    t.string  "taxonomy", :limit => 250,        :null => false
    t.integer "order"
  end

  create_table "wp_links", :primary_key => "link_id", :force => true do |t|
    t.string   "link_url",                             :default => "",  :null => false
    t.string   "link_name",                            :default => "",  :null => false
    t.string   "link_image",                           :default => "",  :null => false
    t.string   "link_target",      :limit => 25,       :default => "",  :null => false
    t.string   "link_description",                     :default => "",  :null => false
    t.string   "link_visible",     :limit => 20,       :default => "Y", :null => false
    t.integer  "link_owner",       :limit => 8,        :default => 1,   :null => false
    t.integer  "link_rating",                          :default => 0,   :null => false
    t.datetime "link_updated",                                          :null => false
    t.string   "link_rel",                             :default => "",  :null => false
    t.text     "link_notes",       :limit => 16777215,                  :null => false
    t.string   "link_rss",                             :default => "",  :null => false
  end

  add_index "wp_links", ["link_visible"], :name => "link_visible"

  create_table "wp_options", :primary_key => "option_id", :force => true do |t|
    t.integer "blog_id",                            :default => 0,     :null => false
    t.string  "option_name",  :limit => 64,         :default => "",    :null => false
    t.text    "option_value", :limit => 2147483647,                    :null => false
    t.string  "autoload",     :limit => 20,         :default => "yes", :null => false
  end

  add_index "wp_options", ["option_name"], :name => "option_name", :unique => true

  create_table "wp_postmeta", :primary_key => "meta_id", :force => true do |t|
    t.integer "post_id",    :limit => 8,          :default => 0, :null => false
    t.string  "meta_key"
    t.text    "meta_value", :limit => 2147483647
  end

  add_index "wp_postmeta", ["meta_key"], :name => "meta_key"
  add_index "wp_postmeta", ["post_id"], :name => "post_id"

  create_table "wp_posts", :primary_key => "ID", :force => true do |t|
    t.integer  "post_author",           :limit => 8,          :default => 0,         :null => false
    t.datetime "post_date",                                                          :null => false
    t.datetime "post_date_gmt",                                                      :null => false
    t.text     "post_content",          :limit => 2147483647,                        :null => false
    t.text     "post_title",                                                         :null => false
    t.text     "post_excerpt",                                                       :null => false
    t.string   "post_status",           :limit => 20,         :default => "publish", :null => false
    t.string   "comment_status",        :limit => 20,         :default => "open",    :null => false
    t.string   "ping_status",           :limit => 20,         :default => "open",    :null => false
    t.string   "post_password",         :limit => 20,         :default => "",        :null => false
    t.string   "post_name",             :limit => 200,        :default => "",        :null => false
    t.text     "to_ping",                                                            :null => false
    t.text     "pinged",                                                             :null => false
    t.datetime "post_modified",                                                      :null => false
    t.datetime "post_modified_gmt",                                                  :null => false
    t.text     "post_content_filtered",                                              :null => false
    t.integer  "post_parent",           :limit => 8,          :default => 0,         :null => false
    t.string   "guid",                                        :default => "",        :null => false
    t.integer  "menu_order",                                  :default => 0,         :null => false
    t.string   "post_type",             :limit => 20,         :default => "post",    :null => false
    t.string   "post_mime_type",        :limit => 100,        :default => "",        :null => false
    t.integer  "comment_count",         :limit => 8,          :default => 0,         :null => false
  end

  add_index "wp_posts", ["post_author"], :name => "post_author"
  add_index "wp_posts", ["post_name"], :name => "post_name"
  add_index "wp_posts", ["post_parent"], :name => "post_parent"
  add_index "wp_posts", ["post_type", "post_status", "post_date", "ID"], :name => "type_status_date"

  create_table "wp_term_relationships", :id => false, :force => true do |t|
    t.integer "object_id",        :limit => 8, :default => 0, :null => false
    t.integer "term_taxonomy_id", :limit => 8, :default => 0, :null => false
    t.integer "term_order",                    :default => 0, :null => false
  end

  add_index "wp_term_relationships", ["term_taxonomy_id"], :name => "term_taxonomy_id"

  create_table "wp_term_taxonomy", :primary_key => "term_taxonomy_id", :force => true do |t|
    t.integer "term_id",     :limit => 8,          :default => 0,  :null => false
    t.string  "taxonomy",    :limit => 32,         :default => "", :null => false
    t.text    "description", :limit => 2147483647,                 :null => false
    t.integer "parent",      :limit => 8,          :default => 0,  :null => false
    t.integer "count",       :limit => 8,          :default => 0,  :null => false
  end

  add_index "wp_term_taxonomy", ["taxonomy"], :name => "taxonomy"
  add_index "wp_term_taxonomy", ["term_id", "taxonomy"], :name => "term_id_taxonomy", :unique => true

  create_table "wp_terms", :primary_key => "term_id", :force => true do |t|
    t.string  "name",       :limit => 200, :default => "", :null => false
    t.string  "slug",       :limit => 200, :default => "", :null => false
    t.integer "term_group", :limit => 8,   :default => 0,  :null => false
  end

  add_index "wp_terms", ["name"], :name => "name"
  add_index "wp_terms", ["slug"], :name => "slug", :unique => true

  create_table "wp_thesis_terms", :primary_key => "option_id", :force => true do |t|
    t.integer "term_id",     :limit => 8,          :default => 0, :null => false
    t.string  "name",        :limit => 100,                       :null => false
    t.string  "taxonomy",    :limit => 32,                        :null => false
    t.string  "title",       :limit => 256,                       :null => false
    t.string  "description", :limit => 256,                       :null => false
    t.string  "keywords",    :limit => 256,                       :null => false
    t.string  "robots",      :limit => 100,                       :null => false
    t.string  "headline",    :limit => 256,                       :null => false
    t.text    "content",     :limit => 2147483647,                :null => false
  end

  create_table "wp_usermeta", :primary_key => "umeta_id", :force => true do |t|
    t.integer "user_id",    :limit => 8,          :default => 0, :null => false
    t.string  "meta_key"
    t.text    "meta_value", :limit => 2147483647
  end

  add_index "wp_usermeta", ["meta_key"], :name => "meta_key"
  add_index "wp_usermeta", ["user_id"], :name => "user_id"

  create_table "wp_users", :primary_key => "ID", :force => true do |t|
    t.string   "user_login",          :limit => 60,  :default => "", :null => false
    t.string   "user_pass",           :limit => 64,  :default => "", :null => false
    t.string   "user_nicename",       :limit => 50,  :default => "", :null => false
    t.string   "user_email",          :limit => 100, :default => "", :null => false
    t.string   "user_url",            :limit => 100, :default => "", :null => false
    t.datetime "user_registered",                                    :null => false
    t.string   "user_activation_key", :limit => 60,  :default => "", :null => false
    t.integer  "user_status",                        :default => 0,  :null => false
    t.string   "display_name",        :limit => 250, :default => "", :null => false
  end

  add_index "wp_users", ["user_login"], :name => "user_login_key"
  add_index "wp_users", ["user_nicename"], :name => "user_nicename"

  create_table "z_business_type_relations", :id => false, :force => true do |t|
    t.integer   "business_type_id",                                       :null => false
    t.integer   "parent_business_type_id",                 :default => 0, :null => false
    t.string    "business_type_name_path", :limit => 1023
    t.integer   "level_id",                                :default => 0
    t.integer   "level1_business_type_id"
    t.integer   "level2_business_type_id"
    t.integer   "level3_business_type_id"
    t.timestamp "created_at",                                             :null => false
    t.timestamp "updated_at",                                             :null => false
  end

  add_index "z_business_type_relations", ["business_type_id"], :name => "fk_relations_categories_business_types"

end
