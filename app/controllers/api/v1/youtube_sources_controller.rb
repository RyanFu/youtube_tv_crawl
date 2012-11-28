class Api::V1::YoutubeSourcesController < Api::ApiController

  def index
    ep_id = params[:ep_id]
    yss = YoutubeSource.ep_youtube_sources(ep_id)
    render :json => yss
  end
end
