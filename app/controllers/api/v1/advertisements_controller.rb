class Api::V1::AdvertisementsController < ApplicationController

  def index
    type_id = params[:type_id].to_i
    if type_id == 0
      advs = Advertisement.where("is_show = ? AND type_id = ?",1,type_id)
      if advs[0].title == nil and advs[0].description == nil 
        adv = Advertisement.where("is_show = ? AND type_id = ?",1,type_id).select("imageurl")
      else
      	adv = Advertisement.where("is_show = ? AND type_id = ?",1,type_id).select("title,imageurl,description")
      end
    elsif type_id == 1
      adv = Advertisement.where("is_show = ? AND type_id = ?",1,type_id).select("imageurl")

    elsif type_id == 2
      
      adv = Advertisement.where("is_show = ? AND type_id = ?",1,type_id).select("title,imageurl")	
    else
      adv = Advertisement.where("is_show = ? AND type_id = ?",1,type_id).select("title,imageurl,description") 		
    end

    render :json => adv
  end


end
