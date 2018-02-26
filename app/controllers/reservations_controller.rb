class ReservationsController < ApplicationController

  before_action :require_login, except: [:new]
  

  def new
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @reservation = current_user.reservations.new(reservation_params)
    @reservation.listing_id = @listing.id
    @customer = current_user.id
    @host = @listing.id

    if @reservation.save
      @reservation_id = @reservation.id
      ReservationJob.perform_now(@customer, @host, @reservation_id)
      redirect_to [@listing,@reservation]
    else
      redirect_to new_listing_reservation_path(@listing)
    end
  end

  def index
    @reservation = Reservation.all
  end

  def show
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.find(params[:id])
  end

private
  def reservation_params
    params.require(:reservation).permit(:user_id, :listing_id, :start_date, :end_date, :total_price)
  end

end
