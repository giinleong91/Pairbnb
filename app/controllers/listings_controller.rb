class ListingsController < ApplicationController

	# before_action :set_listing, only: [:edit, :update, :show]

	def new
		@listing = Listing.new

	end

	def index
		@listings = Listing.all
		@listings = Kaminari.paginate_array(@listings).page(params[:page])
	end

	def create
		@listing = current_user.listings.new(listing_params)
		if @listing.save
			redirect_to root_path
		else
			render "new"
		end
	end


	def show
		@listing = Listing.find_by_id(params[:id])
	end

	def edit
		@listing = current_user.listings.find(params[:id])
	end

	def update
		@listing = current_user.listings.find(params[:id])
		@listing.update(listing_params)
		redirect_to listings_path
	end

	def destroy
		@listing = current_user.listings.find(params[:id])
		@listing.destroy
		redirect_to listings_path
	end

	def search
		@listing = if params[:query]
		Listing.where(title: params[:query])
		else
		Listing.all
	end
	end

	def filter
		@listings = if params[:amenities]
		Listing.where("amenities @> ARRAY[?]::text[]",params[:amenities])
		else
		Listing.all 
	end
	end

	def cart
		@listings = Listing.where(date: params(:date)) 
	end

	private
	# def set_listing
	# 	@listing = Listing.find(params[:id])
	# end
	def listing_params
		params.require(:listing).permit(:title, :amount, :date, :query, amenities: [])
	end
end