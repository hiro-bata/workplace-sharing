class Post < ApplicationRecord
 
  validates :content, presence: true, length: {maximum: 255}
  validates :store_name, presence: true, length: {maximum: 20}
  validates :access, presence: true, length: {maximum: 15}
 
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites, dependent: :destroy
  
  mount_uploader :image, ImageUploader
  
  
end
