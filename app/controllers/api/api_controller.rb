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
    promotion = {:picture_link => "http://ext.pimg.tw/jumplives/1352973893-4060856514.png?v=1352973903", 
                 :link => "http://goo.gl/xrzTe",
                 :tilte => "幫電視連續劇評分",
                 :description => "歡迎到 Google Play 給電視連續劇中肯的建議與評價, 謝謝！",
                 :version => 9
    }

    render :json => promotion.to_json
  end

  def version_check
    version = {:version_code => 45, 
                 :message => "1. 可自行選擇是否高畫質播放(HQ)影片(建議網路穩定下收看)
2. 增加熱門推薦戲劇
3. 增加更多來源內部播放功能
4. 新劇上架: 女王的誕生, 浪漫滿屋, 大漢天子, 詐欺遊戲, SPEC 等超過20部劇"
    }

    render :json => version.to_json
  end

end