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

  def promotion
    promotion = {:picture_link => "http://ext.pimg.tw/jumplives/1352973893-4060856514.png?v=1352973903", 
                 :link => "http://goo.gl/uIxK6",
                 :tilte => "請檢查APP版本",
                 :description => "你好,因為舊版本有些程式上的錯誤,請務必更新至最新的電視連續劇APP, 謝謝！",
                 :version => 3
    }

    render :json => promotion.to_json
  end

end