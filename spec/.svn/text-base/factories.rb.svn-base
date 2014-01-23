  Factory.define :user do |f|
  # OPTIONAL CALLBACKS:
  # after_build  { |user| do_something_to(user) }
  # after_create { |user| do_something_else_to(user) }
  # can do multiple of same kind
  # after_create { this_runs_first }
  # after_create { then_this }
    f.association :purchase, :factory => :user_purchase #, :attribute_overwritten => 'attr_val'
    f.location_id 985 # need db refactoring complete to use location association as above
    f.sequence(:email) { Factory.next(:email) }
    f.phone { Faker::PhoneNumber.phone_number }
    f.hobbies "Internet, search engines, web development"
  end

  Factory.define :friend, :parent => :user do |f|
    #inherits all above 'user' attributes, can override or add
  end

  Factory.define :user_purchase do |f|
      f.association :user#, :attribute_overwritten => 'Attr_val'
      f.purchase_date {Time.now.to_s(:db)}
      f.purchase_status 'Failed'
      f.amount 60.00
      f.buyer_email 'tester@likelist.com'
      f.sequence(:receipt) { Factory.next(:receipt) }
  end

  Factory.define :business do |f|
    f.association :city
    f.business_name 'Brians Carpet & Upholstery Cleaning'
    f.business_type_id '47310'
    f.business_user_id 0
    f.address1 '154 Brittany Rd'
    f.state_code 'MA'
    f.zip_code '01151'
    f.business_phone {Faker::PhoneNumber.phone_number}
    f.website { Faker::Internet.domain_name}
    f.business_info  { Faker::Lorem.sentence(6)}
    f.latitude '42.156342'
    f.longitude '-72.513893'
    f.is_deleted false
    f.source 'Acxiom'
    f.source_external_id '0133603723'
    f.reindex 'n'
    f.version '5'
    f.category_id '25920'
    f.business_entity_id ''
    f.claimed_on '0000-00-00 00:00:00'
    f.email_display_name ''
    f.hide_address_flag 0
    f.al_provisioning_status 'inactive'
    f.default_image_file_path 0
    f.keywords ''
    f.parent_business_id ''
  end

  Factory.define :promo_message do |f|
    f.association :business #, :attribute_overwritten => 'Attr_val'
    f.association :city
    f.association :transaction_term
    f.one_min_message 'Save 60% when you buy online now.  $10 gift certificates for just $25.'
    f.message_type 'third_party_offer'
    f.start_timestamp '2010-12-16 23:01:52'
    f.end_timestamp '2011-02-03 23:00:01'
    f.email_before_expires_flag '0'
    f.email_sent_flag '0'
    f.impression_count '0'
    f.click_thru_count '0'
    f.version '127'
    f.message_title '$10 Gift Certificate | Your Price $25'
    f.offer_url 'http://www.dpbolvw.net/click-3898228-10451612?url=http%3A%2F%2Fwww.restaurant.com%2Fmicrosite.asp%3Frid%3D337770&sid=7086946'
    f.message_terms {Faker::Lorem.sentence(4)}
    f.data_source_id '1'
    f.transaction_term_id '1'
    f.deal_start_timestamp {Time.now.to_s(:db)}
    f.deal_end_timestamp {Time.now.to_s(:db)}
    f.image_file_path ''
    f.purchase_price 1
    f.retail_value 2
    f.max_quantity_per_person 5
    f.min_quantity_per_person 5
    f.max_quantity_provided 5
    f.quantity_purchased 5
    f.description {Faker::Lorem.sentence(3)}
    f.gift_headline {Faker::Lorem.sentence(3)}
  end

  Factory.define :transaction_term do |f|
    f.terms {Faker::Lorem.sentence(5)}
    f.effective_start_date {Time.now.to_s(:db)}
    f.effective_end_date {Time.now.to_s(:db)}
  end

  Factory.define :social_coupon, :parent => :promo_message do |f|

  end

  Factory.define :city do |f|
    f.county_id '100005'
    f.city_name 'Aaronsburg'
    f.state_code 'PA'
    f.Latitude '40.899921'
    f.Longitude '-77.453895'
    f.population '490'
    f.c1 'A'
    f.c2 'Aa'
  end

  Factory.define :list do |f|
    f.owner_id 5
    f.list_name 'Default Name'
    f.list_description {Faker::Lorem.sentence(5)}
    f.image_file_path 'images/lists'
    f.is_cool false
  end

  Factory.define :default_list, :parent => :list do |f|
    f.type 'DefaultList'
  end

  Factory.define :top_list, :parent => :list do |f|
     f.type 'TopList'
     f.is_cool true
  end

  Factory.define :custom_list, :parent => :list do |f|
     f.type 'CustomList'
  end

  Factory.define :list_entry do |f|
    f.owner_id
    f.type
    f.entry_business_id
    f.data_source_id
  end

  Factory.define :like, :parent => :list_entry do |f|
    f.type 'Like'
  end

  Factory.define :try, :parent => :list_entry do |f|
    f.type 'Try'
  end
