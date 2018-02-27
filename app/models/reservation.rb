class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  before_save :set_total_price

  def calculate_date_difference
    (self.end_date - self.start_date).to_i
  end

  def set_total_price
     self.total_price = calculate_date_difference * self.listing.price
  end

end 