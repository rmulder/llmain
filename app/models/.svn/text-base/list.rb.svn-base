class List < ActiveRecord::Base

  validates_associated :owner

  belongs_to :owner, :polymorphic => true

  has_many :list_entries, :through => :list_entry_lists do

    def likes
      where(%Q(
          list_entries.type = 'like'
      ))
    end

    def trys
      where(%Q(
        list_entries.type = 'try'
      ))
    end

    def cities_count
      joins(%Q(
        INNER JOIN
          list_entries e ON
          e.type = 'try'
          AND e.entry_business_id = list_entries.entry_business_id
      )).
      joins(%Q(
        INNER JOIN
          tbl_businesses ON
          e.entry_business_id = tbl_businesses.business_id
      )).
      select("COUNT(distinct tbl_businesses.city_id) cnt")[0].cnt
    end

  end

  has_many :list_entry_lists

  has_one :list_geo_scores

  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/gif', 'image/png', 'image/pjpeg', 'image/x-png'],
                                    :message               => 'must be a JPEG, GIF or PNG image'

  # Top List
  scope :top_lists, where("lists.type = 'TopList'")

  # "All" Lists
  scope :all_lists, where("lists.type != 'TopList'")

  # Active Lists
  scope :active_lists, where("lists.type != 'TopList'")

  # Staff Picks
  scope :cool_lists, where('lists.is_cool = 1').where("lists.type = 'CustomList'")

  # Custom Lists
  scope :custom_lists, where("lists.type = 'CustomList'")

  # scope :featured_lists, where("lists.type = 'TopList' or lists.impression_count > 0 or lists.is_cool = 1")
  scope :featured_lists, where("lists.type = 'TopList' OR lists.is_cool = 1")

  # temp fix for undefined method problem in paperclip gem likely due to STI: super doesn't work
  def avatar_content_type
    false
  end

end
