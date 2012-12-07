class AddIsShowToDramas < ActiveRecord::Migration
  def change
    add_column :dramas, :is_show, :boolean, :default => false
  end
end
