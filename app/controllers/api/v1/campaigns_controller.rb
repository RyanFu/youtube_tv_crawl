class Api::V1::CampaignsController < ApplicationController


  def index
    campaigns = Campaign.where("is_show = 1").select("title,imageurl,description,id")
    response = []
    campaigns.each do |campaign|
      n ={}
      n["title"] = campaign.title
      n["imageurl"] = campaign.imageurl
      n["description"] = campaign.id
      ticket_count = Ticket.where("campaign_id = ?",campaign.id).count + 2000
      n["ticket_count"] = ticket_count
      response << n 
    end
    render :status=>200, :json => response.to_json
  end	

end
