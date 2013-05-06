class Api::V1::DevicesController < ApplicationController

  def create
  	registration_id = params[:registration_id]
  	device_id = params[:device_id]
    
    @device = Device.where("registration_id = ?", registration_id)[0]
    
    if @device
      
    else
      @device = Device.new
      @device.registration_id = registration_id
      @device.device_id = device_id
    end  
   
    if @device.save
      render :status=>200, :json=>{:message => "success"}
    else
      render :status=>401, :json=>{:message=> "create fail" }
    end

  end

end
