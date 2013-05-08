# encoding: utf-8
require 'gcm'

class GcmSender
  def sendMessage type_id, sort_id, message
    gcm = GCM.new("AIzaSyDbiMXETtfdG4K4mUzz3IDVkND5K2jowUM")

    Device.select("registration_id").find_in_batches( :batch_size => 1000 ) do |devices|
      registration_ids = []  	
  	  devices.each do |device|
        registration_ids << device.registration_id
      end
      options = {data: {type_id: type_id, sort_id: sort_id, message: message}, collapse_key: "updated_score"}
      response = gcm.send_notification(registration_ids, options)
    end
  end
end