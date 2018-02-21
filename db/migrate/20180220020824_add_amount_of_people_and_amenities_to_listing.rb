class AddAmountOfPeopleAndAmenitiesToListing < ActiveRecord::Migration[5.0]
  def change
  	add_column :listings, :amount, :integer
  	add_column :listings, :amenities, :text, array: true, default: []
  end
end
