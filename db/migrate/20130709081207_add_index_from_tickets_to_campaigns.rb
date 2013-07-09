class AddIndexFromTicketsToCampaigns < ActiveRecord::Migration
  def change
  	add_index :tickets, :camp_id
  end
end
