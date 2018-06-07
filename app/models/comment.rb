class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :pictures, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :pictures, reject_if: :all_blank, allow_destroy: true
  validates :cmt, presence: true, length: { maximum: 655_36 }
  validates :user_id, presence: true
  validates :post_id, presence: true
end
