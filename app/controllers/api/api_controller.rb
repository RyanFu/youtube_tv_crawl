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
    version = {:version_code => 36, 
                 :message => "1. 回饋大家一直以來的支持, 電視連續劇 努力為大家取得 火影忍者 全球首部展 63折 的專屬優惠! 
2. 增加 路長情更長, PMAM, 精忠岳飛, 急救病棟24小時5, 庶務二課2013 等20多部新劇"
    }

    render :json => version.to_json
  end

end