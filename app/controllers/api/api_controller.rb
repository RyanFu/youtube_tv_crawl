# encoding: UTF-8
class Api::ApiController  < ActionController::Base
  respond_to :json
  before_filter :check_format_json
  
  def check_format_json
    if request.format != :json
        render :status=>406, :json=>{:message=>"The request must be json"}
        return
    end
  end

  #def promotion
  #  promotion = {:picture_link => "http://ext.pimg.tw/jumplives/1352973893-4060856514.png?v=1352973903", 
  #               :link => "http://goo.gl/4mnWv",
  #               :tilte => "幫電視連續劇評分",
  #               :description => "歡迎到 Google Play 給電視連續劇中肯的建議與評價, 謝謝！",
  #               :version => 6
  #  }

  def promotion
    promotion = {:picture_link => "http://pic.pimg.tw/jumplives/1367922942-4188405356.jpg?v=1367922978", 
                 :link => "https://play.google.com/store/apps/details?id=com.jumplife.movienews&referrer=utm_source%3Dtv_drama_inapp%26utm_campaign%3Dtv_drama_inapp",
                 :tilte => "電影窩",
                 :description => "電影經典名句, 深度影評, 明星趣聞 - 趕快加入窩在電影窩App的行列吧!",
                 :version => 8
    }

    render :json => promotion.to_json
  end

  def version_check
    version = {:version_code => 29, 
                 :message => "1. 新增Youtube 影片高畫質播放
2. 修復部份裝置無法全螢幕問題
3. 新增影片在app內部快速播放
4. 新增連續播放"
    }

    render :json => version.to_json
  end

end