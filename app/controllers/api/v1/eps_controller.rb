class Api::V1::EpsController < Api::ApiController

  def index
    drama_id = params[:drama_id]
    eps = Ep.drama_eps(drama_id)
    render :json => eps
  end
end
