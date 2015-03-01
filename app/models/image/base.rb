class Image::Base < ActiveRecord::Base

  self.table_name = "images"
  mount_uploader :image, ImageUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  # Associations
  belongs_to :imageable, :polymorphic => true

  # Callbacks
  after_save :crop_image

  def crop_image
    image.recreate_versions! if crop_x.present?
  end

  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
    {
      "name" => read_attribute(:image),
      "size" => image.size,
      "full_url" => image.url,
      "thumbnail_url" => image.thumb.url,
      "large_url" => image.large.url,
      "url" => "/admin/images/#{id}",
      "delete_type" => "DELETE"
    }
  end

end
