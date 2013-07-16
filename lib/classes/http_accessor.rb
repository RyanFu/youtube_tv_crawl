# encoding: utf-8
require "httpclient"
require 'delayed_job_active_record'
class HttpAccessor

  def update_ticket_wonder ticket
  	httpc = HTTPClient.new
    
    code = ticket.serial_num
    member = ticket.registration_id
    name = ticket.name
    email = ticket.email

    param = {'account'=>'apiuser003', 'password'=>'iordgiuhgoeogitrothortijhogpe', 'code'=>"#{code}",'member'=> "#{member}", 'name'=> "#{name}",'email'=>"#{email}",'source'=>'電視連續劇'}
    #res = httpc.post("http://106.187.51.230:8000/api/v1/tickets.json?name=ben&email=aga111@gamil&registration_id=939393&campaign_id=1")	
	  res = httpc.post("http://wondershow.tw/ser/connect/naruto/register", param)
    #p"============"
    #p param
    #p res.body

  end
  handle_asynchronously :update_ticket_wonder, :run_at => Proc.new { 1.seconds.from_now }
end