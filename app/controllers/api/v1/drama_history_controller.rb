class Api::V1::DramaHistoryController < ApplicationController

  def index
    history = DramaHistory.select("release_date, dramas_str").last(10).reverse

    render :json => history.to_json
  end
end
