class VideosController < ApplicationController
  def show
    @video = YoutubeSource.first
  end
end
