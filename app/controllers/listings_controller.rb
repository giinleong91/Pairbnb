class ListingsController < ApplicationController

	# before_action :set_listing, only: [:edit, :update, :show]


	def new
		@listing = Listing.new
	end

	def index
		@listings = Listing.all
		@listings = Kaminari.paginate_array(@listings).page(params[:page])
	end

	def a_title
		@listings = Listing.a_title
		@listings = Kaminari.paginate_array(@listings).page(params[:page])
		render "listings/index"
	end

	def d_title
		@listings = Listing.d_title
		@listings = Kaminari.paginate_array(@listings).page(params[:page])
		render "listings/index"
	end

	def a_price
		@listings = Listing.a_price
		@listings = Kaminari.paginate_array(@listings).page(params[:page])
		render action: :index
	end

	def d_price
		@listings = Listing.d_price
		@listings = Kaminari.paginate_array(@listings).page(params[:page])
		render action: :index
	end

	def city
		@listings = Listing.city
		@listings = Kaminari.paginate_array(@listings).page(params[:page])
		render action: :index
	end

	def create
		@listing = current_user.listings.new(listing_params)
		if @listing.save!
			redirect_to @listing
		else
			render "new"
		end
	end

	def indexall
		@listings = Listing.all
		@listings = Kaminari.paginate_array(@listings).page(params[:page])
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

	# def search
	# 	# @listing = Listing.find(params[:city])
	# 	@listings = Listing.where(nil)
	# 	filtering_params(params).each do |key, value|
	# 		@listings = @listings.public_send(key,value) if value.present?
	# 	@listings = Kaminari.paginate_array(@listings).page(params[:page])
	# 	end

	# 	render template: "listings/search"
	# end

	def search
		@listing = Listing.search_title(params[:search])
		respond_to do |format|
			format.json {	render json:@listing }
			format.html { render "listings/search" }
		 	@listing = Kaminari.paginate_array(@listing).page(params[:page])
		end
	end

	# def search
	# 	@listing = if params[:query]
	# 		Listing.where(title: params[:query])
	# 	else
	# 		Listing.all
	# 	end
	# end

	def filter
		@listings = if params[:amenities]
		Listing.where("amenities @> ARRAY[?]::text[]",params[:amenities])
		else
		Listing.all 
		end
	end

	private

  # def sort_column
  #   params[:sort] || "title"
  # end

  # def sort_direction
  #   params[:direction] || "asc"
  # end

  # def filtering_params(params)
  # 	params.slice(:title, :price, :amount, :city)  	
  # end

	def listing_params
		params.require(:listing).permit(:title, :amount, :date, :query, :image, :price, :city, amenities: [])
	end

end