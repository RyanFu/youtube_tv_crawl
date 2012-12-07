class Api::V1::DramasController < Api::ApiController

  def index
    @drama_ids = Drama.select(:id).show_dramas.map{|d| d.id}
    render :json => @drama_ids
  end

  def dramas_info
    dramas_id = params[:dramas_id]
    dramas_id_array = dramas_id.split(",")
    @dramas = Drama.select('id,name,introduction,poster_url,eps_count,release_date,area_id').where(['id in (?)', dramas_id_array])
    render :json => @dramas.to_json
  end

end
