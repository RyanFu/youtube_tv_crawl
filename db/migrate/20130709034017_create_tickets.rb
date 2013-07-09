class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.string :email
      t.string :registration_id
      t.integer :serial_num
      t.integer :camp_id
      t.timestamps
    end
  end
end
