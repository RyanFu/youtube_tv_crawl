class VideosController < ApplicationController
  def show
    @video = YoutubeSource.find(params[:id])
  end
end
