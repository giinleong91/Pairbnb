class ReservationMailer < ApplicationMailer
  default from: 'from@example.com'

  def booking_email(customer, host, reservation_id)
    @reservation = Reservation.find(reservation_id)
    @customer = User.find(customer)
    listing = Listing.find(host).id
    @host = Listing.find(host).user_id
    @host = User.find(@host).email
    @url = "Homepage"
    mail(to: @customer.email,
        subject: 'Reservation had been made')
  end
end
