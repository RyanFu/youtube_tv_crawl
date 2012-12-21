class Api::V1::DramasController < Api::ApiController

  def index
    @drama_ids = Drama.select(:id).show_dramas.map{|d| d.id}
    render :json => @drama_ids
  end

  def dramas_info
    dramas_id = params[:dramas_id]
    dramas_id_array = dramas_id.split(",")
    @dramas = Drama.select('id,name,introduction,poster_url,eps_num_str,release_date,area_id').where(['id in (?)', dramas_id_array])
    render :json => @dramas.to_json
  end

  def update
    drama = Drama.find(params[:id])
    drama.views += 1
    if drama.save
      render :status=>200, :json=>{:message => "success"}
    else
      logger.info("error message: #{@record.errors.messages}")
      render :status=>401, :json=>{:message=> "update fail" }
    end
  end

  def dramas_with_views
    @drama_ids = Drama.select('id,views,eps_num_str').show_dramas
    render :json => @drama_ids
  end

end
