class AddIsShowV2ToDramas < ActiveRecord::Migration
  def change
    add_column :dramas, :is_show_v2, :boolean, :default => false
  end
end
