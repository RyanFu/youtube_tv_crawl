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
                 :link => "https://play.google.com/store/apps/details?id=com.jumplife.movienews",
                 :tilte => "電影窩 App",
                 :description => "新奇有趣的新聞，令人難忘的名言，電影的大小事都在電影窩！",
                 :version => 7
    }

    render :json => promotion.to_json
  end

  def version_check
    version = {:version_code => 26, 
                 :message => "1. 修正 關於我們 破圖問題
2. 修正連續劇觀看集數紀錄錯誤
3. 修正當機錯誤"
    }

    render :json => version.to_json
  end

end