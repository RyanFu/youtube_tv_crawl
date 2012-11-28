class Api::V1::DramasController < Api::ApiController

  def index
    @taiwan_ids = Drama.area_dramas(1).map{|d| d.id}
    @china_ids = Drama.area_dramas(2).map{|d| d.id}
    @korea_ids = Drama.area_dramas(3).map{|d| d.id}
    @japan_ids = Drama.area_dramas(4).map{|d| d.id}
    output = {}
    output["taiwan_ids"] = @taiwan_ids
    output["china_ids"] = @china_ids
    output["korea_ids"] = @korea_ids
    output["japan_ids"] = @japan_ids

    render :json => output
  end

  def dramas_info
    dramas_id = params[:dramas_id]
    dramas_id_array = dramas_id.split(",")
    @dramas = Drama.select('id,name,introduction,poster_url,eps_count,release_date').where(['id in (?)', dramas_id_array])
    render :json => @dramas.to_json
  end

end
