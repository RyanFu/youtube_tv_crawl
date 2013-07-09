class Api::V1::CampaignsController < ApplicationController


  def index
    campaigns = Campaign.where("is_show = 1").select("title,imageurl,description,id")

    render :json => campaigns	
  end	

end
