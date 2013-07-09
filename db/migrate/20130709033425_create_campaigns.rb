class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.string :imageurl
      t.text :description
      t.string :inverse_title
      t.string :inverse_imageurl
      t.text :precaution
      t.boolean :is_show, :default => false
      t.timestamps
    end
  end
end
