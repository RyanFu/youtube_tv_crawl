class ChangeTicketsCampaignId < ActiveRecord::Migration
  def change
  	rename_column(:tickets, :camp_id, :campaign_id)
  end
end
