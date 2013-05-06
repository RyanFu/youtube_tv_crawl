class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :registration_id, :default => ''
      t.string :device_id, :default => ''
      t.timestamps
    end
  end
end
