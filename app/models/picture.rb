class Picture < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  has_attached_file :image,
    styles: { small: "100x100", medium: "200x200", large: "300x300" },
    :path => ":rails_root/public/images/:id/:filename",
    :url  => "/images/:id/:filename"

  validates_attachment_content_type :image, :content_type => /image/
end
