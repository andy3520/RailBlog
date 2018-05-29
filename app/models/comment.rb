class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :cmt, presence: true, length: { maximum: 655_36 }
  validates :user_id, presence: true
  validates :post_id, presence: true
end
