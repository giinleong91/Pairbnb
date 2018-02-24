class BraintreeController < ApplicationController
  
  before_action :require_login
  
  def new
    @client_token = Braintree::ClientToken.generate
  end

  def checkout
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.find(params[:reservation_id])
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    result = Braintree::Transaction.sale(
      :amount => @reservation.total_price,
      :payment_method_nonce => nonce_from_the_client,
      :options => {
        :submit_for_settlement => true
      }
      )
    if result.success?
      redirect_to [@listing,@reservation], :flash => { :success => "Transaction successful!"}
    else
      redirect_to @reservation, :flash => { :error => "Transaction failed. Please try again." }
    end

  end
end
