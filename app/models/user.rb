class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :delete_all
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", large: "500x500>" },
  default_url: "/images/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>", large: "500x500>" },
  default_url: "/system/images/cover-default.jpeg"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true
end
