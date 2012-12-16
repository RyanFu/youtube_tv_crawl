class Api::V1::EpsController < Api::ApiController

  def index
    drama_id = params[:drama_id]
    eps = Ep.by_num_order.drama_eps(drama_id)
    render :json => eps
  end

  def update_ep
    ep = Ep.find(params[:ep_id])
    url = params[:url]
    crawl = MapleCrawler.new
    crawl.fetch url

    puts url
    crawl.rewrite_parse_source ep
    render :json => {"msg" => "success"}
  end
end
