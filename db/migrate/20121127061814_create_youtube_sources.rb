class CreateYoutubeSources < ActiveRecord::Migration
  def change
    create_table :youtube_sources do |t|
      t.string :link
      t.integer :ep_id

      t.timestamps
    end
    add_index :youtube_sources, :ep_id
  end
end
