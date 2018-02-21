class WelcomeController < ApplicationController
	
	def index
		@listings = Listing.all
    @listings = Kaminari.paginate_array(@listings).page(params[:page])
	end

end
