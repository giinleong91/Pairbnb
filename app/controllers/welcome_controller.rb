class WelcomeController < ApplicationController
	
	def index
    
    
		@listings = Listing.order(sort_column + " " + sort_direction)
    @listings = Kaminari.paginate_array(@listings).page(params[:page])
	end

  def show
    @listing = Listing.find(params[:id])
    byebug
  end

  private
  def sort_column
    params[:sort] || "title"
  end
  def sort_direction
    params[:direction] || "asc"
  end

end
