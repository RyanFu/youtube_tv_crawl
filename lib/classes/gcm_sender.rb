# encoding: utf-8
require 'gcm'

class GcmSender
  #type_id, sort_id, message, post_date, dramas_str
  #post_date: 2013/5/5
  #

  def sendMessage
    gcm = GCM.new("AIzaSyDbiMXETtfdG4K4mUzz3IDVkND5K2jowUM")

    Device.select("registration_id").find_in_batches( :batch_size => 1000 ) do |devices|
      registration_ids = []  	
  	  devices.each do |device|
        registration_ids << device.registration_id
      end
      #puts registration_ids

      # {:registration_ids => ["RegistrationID"], :data => {:message_text => "Get on cloud nine"}
      options = {data: {type_id: "1", sort_id: "1", message: "test push message", 
      	         post_date: "2013/5/7", dramas_str: "aaa, bbb, ccc, ddd, eee"}, collapse_key: "updated_score"}
      response = gcm.send_notification(registration_ids, options)
    end
  end
  #registration_ids= ["12", "13"] # an array of one or more client registration IDs
  
  #options = {data: {score: "123"}, collapse_key: "updated_score"}
  #response = gcm.send_notification(registration_ids, options)

end