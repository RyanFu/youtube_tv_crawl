class ChangeTicketsSerialNumToString < ActiveRecord::Migration
  def change
    remove_index :tickets, :camp_id
    add_index :tickets, :campaign_id
    change_column :tickets, :serial_num, :string
  end
end
