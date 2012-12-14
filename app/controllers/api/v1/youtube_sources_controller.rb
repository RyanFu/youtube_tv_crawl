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
end
