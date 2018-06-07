class Picture < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  has_attached_file :image,
    :style => { medium: "300x300>", thumb: "100x100>", original:"1920x1200>" },
    :path => ":rails_root/public/images/:id/:filename",
    :url  => "/images/:id/:filename"
  validates :imageable, presence: true
  validates_attachment_content_type :image, :content_type => /image/
end
