class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :chair_id, null: false
      t.datetime :start, null: false
      t.datetime :end, null: false
      t.integer :sitter_id, null: false
      t.string :status, default: "PENDING"

      t.timestamps
    end

    add_index :reservations, :chair_id
    add_index :reservations, :sitter_id

  end
end
