class ReservationMailer < ApplicationMailer
  default from: 'from@example.com'

  def booking_email(customer, host, reservation_id)
    @reservation = Reservation.find(reservation_id)
    @customer = User.find(customer)
    @listing = Listing.find(host)
    @host = Listing.find(host).user_id
    @host = User.find(@host).email
    @url = Rails.configuration.action_mailer.default_url_options[:host] + '/listings/' + @listing.id.to_s + '/reservations/'+ @reservation.id.to_s
    mail(to: @customer.email,
        subject: 'Reservation had been made')
  end
end
