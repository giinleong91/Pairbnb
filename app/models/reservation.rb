class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  before_save :set_total_price

  validate :overlapping



  def calculate_date_difference
    (self.end_date - self.start_date).to_i
  end

  def set_total_price
     self.total_price = calculate_date_difference * self.listing.price
  end



  private
  def overlapping
    if Reservation.where('? < end_date and ? > start_date', self.start_date, self.end_date).any?
      errors.add(:date, 'it overlaps another')
    end
  end

end 