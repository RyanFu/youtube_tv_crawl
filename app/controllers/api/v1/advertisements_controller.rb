# encoding: utf-8
class Api::V1::AdvertisementsController < ApplicationController

  def index
    type_id = params[:type_id].to_i
    response = []
    if type_id == 0
      n ={}
      n["description"] = "用戶獨享優惠165元"
      n["imageurl"] = "http://pic.pimg.tw/jumplives/1374117884-921708010.jpg?v=1374117915"
      n["title"] = "火影忍者 全球特展"

     # n["imageurl"] = "http://pic.pimg.tw/jumplives/1374117890-655812443.jpg?v=1374117917"
      response << n  
    elsif type_id == 1
      n ={}
     # n["imageurl"] = "http://pic.pimg.tw/jumplives/1374117891-4289730248.jpg?v=1374117917"
     # response << n
    elsif type_id == 2
      n ={}
      n["imageurl"] = "http://pic.pimg.tw/jumplives/1374117884-921708010.jpg?v=1374117915"
      n["title"] = "火影忍者 特展"
      response << n
    else
      n ={}
    #  response << n
    end

    render :json => response.to_json
  end


end
