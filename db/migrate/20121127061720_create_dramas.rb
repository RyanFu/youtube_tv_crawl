class CreateDramas < ActiveRecord::Migration
  def change
    create_table :dramas do |t|
      t.string :name
      t.string :name_en
      t.integer :area_id
      t.text :introduction
      t.string :poster_url
      t.text :actors
      t.string :directors
      t.integer :eps_count, :default => 0
      t.string :release_date
      t.string :link
      t.timestamps
    end
    add_index :dramas, :area_id
  end
end
