class CreateDramaHistories < ActiveRecord::Migration
  def change
    create_table :drama_histories do |t|
      t.string :release_date, :null => false
      t.string :dramas_str, :null => false
      t.timestamps
    end
  end
end
