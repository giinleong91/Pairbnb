class Listing < ApplicationRecord
	belongs_to :user
  has_many :reservations
  has_many :images

  validates :title, presence: true
  validates :amount, presence: true
  validates :amenities, presence: true
  validates :price, presence: true
  
  scope :a_title, -> { order(title: :asc) }
  scope :d_title, -> { order(title: :desc) }
  scope :a_price, -> { order(price: :asc) }
  scope :d_price, -> { order(price: :desc) }
  scope :city, -> (argument) { where("city ILIKE ?", "%#{argument}%")}
  scope :title, -> (argument) { where("title ILIKE ?", "%#{argument}%")}

  scope :price, -> (number) { where("price >= ?", "%#{number}%")}

  # scope :amenities -> (amenities) { where("amenities like ?", "#{amenities}%")}
  # scope :start_with, -> (amount) { where("new like ?", "#{amount}") }

  mount_uploader :image, ImageUploader
end 