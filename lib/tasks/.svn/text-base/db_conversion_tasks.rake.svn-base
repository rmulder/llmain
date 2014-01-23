namespace :db do
  namespace :convert do
    task :business_ratings => :environment do

      obj_types = Hash['mylist'=>'Like', 'watchlist'=>'Try']

      users     = BusinessRating.not_deleted.count(:user_list_id, :group=>:user_list_id)

      users.each_pair do |user_id, like_try_count|

        begin

          the_user       = User.find user_id
          puts "Processing likes & trys for #{the_user.first_name} #{the_user.last_name} (#{like_try_count} likes/trys)"

          # create a new default list
          default_list   = DefaultList.new :user=>the_user
          #default_list.save

          #todo: handle errors on save...

          old_likes_trys = BusinessRating.not_deleted.where(:user_list_id=>user_id)
          puts "\tfound #{old_likes_trys.count} old likes/tries"
          old_likes_trys.each do |biz_rating|
            puts "\t\t#{biz_rating.business.business_name} (#{biz_rating.list_type})"
            list_entry            = Object.const_get(obj_types[biz_rating.list_type]).new
            list_entry.business   = biz_rating.business
            list_entry.created_at = biz_rating.rated_on
            #todo add to default list
          end

          # todo handle custom lists...


        rescue ActiveRecord::RecordNotFound  => the_exception
          puts the_exception.message

        end


      end

      users     = nil


    end
  end
end