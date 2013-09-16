class Api::V1::YoutubeSourcesController < Api::ApiController

  def index
    ep_id = params[:ep_id]
    yss = YoutubeSource.ep_youtube_sources(ep_id)
    render :json => yss
  end

  def find_by_drama_and_ep_num
    drama_id = params[:drama_id]
    num = params[:num]
    ep = Ep.where(:drama_id => drama_id, :num => num)
    yss = YoutubeSource.ep_youtube_sources(ep[0].id)
    render :json => yss
  end

  def get_56_sign

    vid = params[:vid]

    appkey = "3000002938"

    secret = "0eb65aefc86ca4b5"

    #vid = OTU4OTQ5NDg
    str_not_system_str = Digest::MD5.hexdigest("vid=#{vid}") #先把非系統參數用MD5加密

    timestamp = Time.now.to_time.to_i.to_s

    sign = Digest::MD5.hexdigest(str_not_system_str + "##{appkey}##{secret}#" + timestamp)

    result = { "sign" => sign, "timestamp" => timestamp }

    render :json => result



    #puts sign

    #url = URI.parse("http://oapi.56.com/video/mobile.json?appkey=#{appkey}&sign=#{sign}&ts=" + Time.now.to_time.to_i.to_s + "&vid=#{vid}")

    #puts url

    #response = Net::HTTP.get_response(url)
    

    #json = JSON.parse(response.body)

    #link = json["info"]["rfiles"][0]["url"]
            
  end

end
