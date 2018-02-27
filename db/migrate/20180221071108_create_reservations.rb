class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.date :end_date
      t.references :user, index: true, foreign_key: true
      t.references :listing, index: true, foreign_key: true
      t.integer :total_price

      t.timestamps
    end
  end
end
