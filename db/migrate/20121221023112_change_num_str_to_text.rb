class ChangeNumStrToText < ActiveRecord::Migration
  def up
    change_column :dramas, :eps_num_str, :text
  end

  def down
    change_column :dramas, :eps_num_str, :string
  end
end
