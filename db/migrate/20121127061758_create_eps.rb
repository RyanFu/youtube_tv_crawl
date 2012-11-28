class CreateEps < ActiveRecord::Migration
  def change
    create_table :eps do |t|
      t.string :title
      t.integer :drama_id
      t.integer :num
      t.timestamps
    end
    add_index :eps, :drama_id
  end
end
