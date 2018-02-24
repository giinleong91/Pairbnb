class AddPriceToListing < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :price, :integer, default: 10
  end
end