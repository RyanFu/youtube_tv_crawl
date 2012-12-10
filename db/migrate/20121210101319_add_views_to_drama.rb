class AddViewsToDrama < ActiveRecord::Migration
  def change
    add_column :dramas, :views, :int, :default => 0
  end
end
