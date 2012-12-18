class AddEpIdsToDrama < ActiveRecord::Migration
  def change
    add_column :dramas, :eps_num_str, :string
  end
end
