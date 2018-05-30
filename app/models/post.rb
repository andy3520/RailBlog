class Post < ApplicationRecord
  belongs_to :user
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :comments, dependent: :delete_all
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 655_36 }
end
