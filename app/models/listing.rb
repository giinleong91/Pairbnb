class Listing < ApplicationRecord
	belongs_to :user
  has_many :reservations
  has_many :images
  
  mount_uploader :image, ImageUploader
end 