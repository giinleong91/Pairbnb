class ReservationsController < ApplicationController

  before_action :require_login, except: [:new]
  def new
    @listing = Listing.all
  end

  def create
  end

  def index
    @listing = Listing.all
  end
end
