class Image < ActiveRecord::Base

  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/gif', 'image/png', 'image/pjpeg', 'image/x-png'],
                                    :message               => 'must be a JPEG, GIF or PNG image'

  has_attached_file :image, :styles => {:medium => "320x240>", :thumb => "100x100>"},
                    :storage         => :s3,
                    :s3_credentials  => "#{::Rails.root.to_s}/config/amazon_s3.yml",
                    :bucket          => "likelist_#{Rails.env}",
                    :path            => ":class/:id/:basename_:style.:extension"

  belongs_to :reference, :polymorphic => true

  def reference_type=(sType)
    super(sType.to_s.classify.constantize.base_class.to_s)
  end

end
