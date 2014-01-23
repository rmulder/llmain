Lists::Application.routes.draw do

  match '/auth/:provider/create/:uid/:token' => 'authentications#create'
  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/:provider/:id', :to => 'authentications#sign_in_existing', :constraints => {:id => /\d+/}
  match '/auth/failure' => 'authentications#failure'
  #match '/auth/fix_fs' => 'authentications#fix_fs'
  match '/authentications/:provider/:id/business/:business_id' => 'authentications#business', :constraints => {:id => /\d+/}
  match '/authentications/:provider/:id/friends' => 'authentications#friends', :constraints => {:id => /\d+/}
  match '/authentications/:provider/:id/checkins' => 'authentications#checkins', :constraints => {:id => /\d+/}
  match '/authentications/:provider/:id/full_profile' => 'authentications#full_profile', :constraints => {:id => /\d+/}
  match '/authentications/:provider/:id/user' => 'authentications#user', :constraints => {:id => /\d+/}
  match '/authentications/:provider/:id/checkins/likes' => 'authentications#likes_from_checkins', :constraints => {:id => /\d+/}
  match '/authentications/:provider/:id/likes' => 'authentications#likes', :constraints => {:id => /\d+/}

  devise_for :users, :controllers => {:registrations => 'registrations', :sessions => 'sessions'}, :path_names => { :sign_in => 'login', :sign_out => 'logout'}
  resources :authentications

  root :to => "application#index"

  resources :images do
    collection do
      get :image_download
      post :image_upload
      post :save
      get :crop
    end
  end

    namespace "admin" do
      resources :users do
        get :dashboard, :on => :collection
      end
      resources :businesses do
        get :dashboard, :on => :collection
        get :geo, :on => :collection
        get :edit, :on => :member
      end

    end

    resources :user do
      resources :likes
      resources :trys
      resources :friend_lists

      resources :user_purchases do
        member do
	        get :purchase
	        post :purchase
	        get :purchase_test
	        get :complete
	        post :complete
	        get :purchase_callback
	        post :purchase_callback
	        get :cancel_callback
	        post :cancel_callback
	        get :refund
	        post :refund
	        get :refund_complete
	        post :refund_complete
	        get :refund_callback
	        post :refund_callback
	        get :cancel_refund_callback
	        post :cancel_refund_callback
        end
      end

      resources :lists do
        resources :comments
        get :manage, :on => :collection
      end
      resources :transaction_terms
      resources :images

    end

      resources :user_purchases do
        member do
	        get :purchase
	        post :purchase
	        get :purchase_test
	        get :complete
	        post :complete
	        get :purchase_callback
	        post :purchase_callback
	        get :cancel_callback
	        post :cancel_callback
	        get :refund
	        post :refund
	        get :refund_complete
	        post :refund_complete
	        get :refund_callback
	        post :refund_callback
	        get :cancel_refund_callback
	        post :cancel_refund_callback
        end
      end

      resources :cities do
        resources :social_coupons
          resources :businesses do
          #TODO: to discuss: nesting more than one level deep okay here? ( drawbacks? can arguably cause long-term maintenance issues? )
            resources :likes
            resources :trys

          ## maps to /cities/:city_id/businesses/:business_id/social_coupons/sold
            resources :social_coupons do
              get :sold, :on => :collection
              get :reserved, :on => :collection
              get :top_ten, :on => :collection
           end
          #endpoint for ajax/redis calls to populate recent activity wall
          get :recent_activity, :on => :member
        end
        resources :user
      end

  resources :businesses do
    collection do
      get :dashboard
      get :geo
    end

    member do
      post :set_business_website
      get :edit
    end

    resources :likes
    resources :trys
    resources :promo_messages

    resources :social_coupons do
      member do
        get :details
        get :check_status
        get :campaign_overview
        get :campaign_details
        get :auto_complete_for_business_name
        get :auto_complete_for_city_name
      end
      collection do
        get :deal_cities
        get :deal_of_the_day
        get :deals_of_the_day
        get :payout_report
      end
    end

  end

  resources :social_coupons do
      member do
        get :details
        get :check_status
        get :campaign_overview
        get :campaign_details
        get :auto_complete_for_business_name
        get :auto_complete_for_city_name
        get :payout_report
      end
      collection do
        get :deal_cities
        get :deal_of_the_day
        get :deals_of_the_day
        get :payout_report
      end
  end

  match 'social_coupons/:id/email_template/:template' => 'social_coupons#email_template'

  resources :coupons

  match 'payment_transactions_coordinator/duplicates_needing_refunds' => 'payment_transactions_coordinator#duplicates_needing_refunds'

  resources :user_purchases do
    member do
      get :purchase
      post :purchase
      get :purchase_test
      get :complete
      post :complete
      get :purchase_callback
      post :purchase_callback
      get :cancel_callback
      post :cancel_callback
      get :refund
      post :refund
      get :refund_complete
      post :refund_complete
      get :refund_callback
      post :refund_callback
      get :cancel_refund_callback
      post :cancel_refund_callback
    end
  end

#  match 'coupons/:id/print' => 'coupons#print', :as => :coupon_print
#  match 'coupons/:id/qr_code' => 'coupons#qr_code', :as => :coupon_qr_code
#  match 'coupons' => 'coupons#index', :as => :coupon_index

# The priority is based upon order of creation:

# first created -> highest priority.

# Sample of regular route:
#   match 'products/:id' => 'catalog#view'
# Keep in mind you can assign values other than :controller and :action

# Sample of named route:
#   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
# This route can be invoked with purchase_url(:id => product.id)

# Sample resource route (maps HTTP verbs to controller actions automatically):
#   resources :products

# Sample resource route with options:
#   resources :products do
#     member do
#       get 'short'
#       post 'toggle'
#     end
#
#     collection do
#       get 'sold'
#     end
#   end

# Sample resource route with sub-resources:
#   resources :products do
#     resources :comments, :sales
#     resource :seller
#   end

# Sample resource route with more complex sub-resources
#   resources :products do
#     resources :comments
#     resources :sales do
#       get 'recent', :on => :collection
#     end
#   end

# Sample resource route within a namespace:
#   namespace :admin do
#     # Directs /admin/products/* to Admin::ProductsController
#     # (app/controllers/admin/products_controller.rb)
#     resources :products
#   end

# You can have the root of your site routed with "root"
# just remember to delete public/index.html.
# root :to => "welcome#index"

# See how all your routes lay out with "rake routes"

# This is a legacy wild controller route that's not recommended for RESTful applications.
# Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
