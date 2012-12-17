class YoutubeSourcesController < ApplicationController
  def edit
    @source = YoutubeSource.find(params[:id])
  end
  def update
    @source = YoutubeSource.find(params[:id])
    if @source.update_attributes(params[:youtube_source])
      redirect_to :controller => 'eps', :action => 'show', :id => @source.ep_id
    else
      render :action => "edit" 
    end
  end
  def new
    @ep_id = params[:ep_id]
  end

  def create
    @source = YoutubeSource.new(params[:youtube_source])
    if @source.save
      redirect_to :controller => 'eps', :action => 'show', :id => @source.ep_id
    else
      render :action => "new", :ep_id => @source.ep_id
    end
  end

  def destroy
    @source = YoutubeSource.find(params[:id])
    @source.destroy
    redirect_to :controller => 'eps', :action => 'show', :id => @source.ep_id
  end
end
