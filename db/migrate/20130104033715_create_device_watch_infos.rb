class CreateDeviceWatchInfos < ActiveRecord::Migration
  def change
    create_table :device_watch_infos do |t|
      t.string :registration_id, :null => false
      t.integer :drama_id
      t.text :watched_ep

      t.timestamps
    end
    add_index :device_watch_infos, :registration_id, :unique => true
  end
end
