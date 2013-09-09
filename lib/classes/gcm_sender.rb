# encoding: utf-8
require 'gcm'

class GcmSender

  #撥放次數0, 上架時間 1, 2013 2,2012 3 ,2011之前 4
  #type0, 1, 2,3

  def sendMessage type_id, sort_id, message
    gcm = GCM.new("AIzaSyDbiMXETtfdG4K4mUzz3IDVkND5K2jowUM")

    Device.select("id, registration_id").find_in_batches( :batch_size => 1000, :conditions => ['id >= ? AND id <= ?', 1200001, 1344000] ) do |devices|

      registration_ids = []  	
  	  devices.each do |device|
        puts device.id
        registration_ids << device.registration_id
      end

      #puts registration_ids

      #options = {data: {type_id: type_id, sort_id: sort_id, message: message}, collapse_key: "updated_score"}
      #response = gcm.send_notification(registration_ids, options)

      options = {data: {type_id: 3, sort_id: 1, message: "新劇上架: 蘭陵王, 媽祖, 我愛你愛你愛我, 山田君與七魔女等9部新劇
另外, 喜歡動畫與美劇的朋友, 歡迎到關於我們下載新上架的 動畫大學 與 經典美劇!"}, collapse_key: "updated_score"}
      response = gcm.send_notification(registration_ids, options)
    end
  end
end