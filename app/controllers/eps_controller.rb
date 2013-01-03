class EpsController < ApplicationController
  # GET /Eps
  # GET /Eps.json
  def index
    @eps = Ep.paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @Eps }
    end
  end

  def search
    search_text = params[:search].strip
    @eps = Ep.where(["title like ?", "%#{search_text}%"]).order("num DESC")
  end

  def update_ep
    ep = Ep.find(params[:ep_id])
    url = params[:url]
    crawl = MapleCrawler.new
    crawl.fetch_without_encode_url url
    crawl.rewrite_parse_source ep
    redirect_to :action => 'show', :id => ep.id
  end

  # GET /Eps/1
  # GET /Eps/1.json
  def show
    @ep = Ep.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ep }
    end
  end

  # GET /Eps/1/edit
  def edit
    @ep = Ep.find(params[:id])
  end
end
