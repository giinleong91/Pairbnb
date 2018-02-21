class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
    	t.string :title
    	t.string :user_id

    	t.timestamps
    end
  end
end
