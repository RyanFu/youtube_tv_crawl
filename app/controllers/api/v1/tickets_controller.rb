class Api::V1::TicketsController < ApplicationController

  def create
  	name = params[:name]
  	email = params[:email]
  	registration_id = params[:registration_id]
    camp_id = params[:campaign_id]
    
    tickets = Ticket.where("email = ? and campaign_id =?",email,camp_id)
    
    if tickets.size > 0
      render :status=>200, :json=>{:message => "mail duplicate "}
      
    else
      @ticket = Ticket.new
      @ticket.name = name
      @ticket.email = email     
      @ticket.registration_id = registration_id
      
      serial = 0
      until serial == nil
        serial_nums = Ticket.select("serial_num").last.serial_num.to_i
        serial_num = serial_nums + 1
        serial = Ticket.find_by_serial_num(serial_num)

        until serial == nil
        serial_num = serial.serial_num.to_i + 1
        serial = Ticket.find_by_serial_num(serial_num)
        end
      end
      

      @ticket.serial_num = "%05d"% serial_num
      @ticket.campaign_id = camp_id

      if @ticket.save

      	inverse = Campaign.where("is_show = ? AND id = ?",1,camp_id).select("inverse_title,inverse_imageurl,precaution")
        

        n ={}
        
        n["serial_num"] =@ticket.serial_num
        n["inverse_title"] = inverse[0].inverse_title
        n["inverse_imageurl"] = inverse[0].inverse_imageurl
        n["precaution"] = inverse[0].precaution
 



        render :status=>200, :json => n.to_json
      else
        render :status=>401, :json=>{:message=> "create fail" }
      end
    end  
   


  end	
end
