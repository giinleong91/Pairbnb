class WelcomeController < ApplicationController

  helper_method :sort_column, :sort_direction
	
	def index
    @listings = Listing.all
		@listings = Listing.order(sort_column + " " + sort_direction)
    @listings = Kaminari.paginate_array(@listings).page(params[:page])
	end

  def show
    @listing = Listing.find(params[:id])
  end

  private

  def sort_column
    params[:sort] || "title"
  end

  def sort_direction
    params[:direction] || "asc"
  end

end
