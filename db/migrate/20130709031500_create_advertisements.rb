class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :title
      t.string :imageurl
      t.text :description
      t.boolean :is_show, :default => false
      t.integer :type_id
      t.timestamps
    end
  end
end
