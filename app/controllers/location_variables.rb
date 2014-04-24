module LocationVariables
  def self.included(base)
    base.class_eval do
      before_filter :set_location_instance_vars
    end
  end

  def set_location_instance_vars
    @kommunen = Kommune.all
    @quarters = all_quarters
    @quarters_id_to_location = @quarters.each_with_object({}) do |quarter, hash|
      hash[quarter.id] = {
        coords: [quarter.lat, quarter.long],
        kommune: quarter.kommune
      }
    end

    @map_lat, @map_lng = '50.759047', '6.130028'
    @map_zoom = 11

    if quarter = (params[:quarter].presence or params[:quarters].presence)
      @quarter_id = quarter.to_i
      @quarter = @quarters.find { |q| q.id == @quarter_id }
      @map_lat = @quarter.long
      @map_lng = @quarter.lat
      @map_zoom = 14
    elsif kommune = (params[:kommune].presence or params[:kommunen].presence)
      @kommune_id = kommune.to_i
      @kommune = @kommunen.find { |k| k.id == @kommune_id }
      @map_lat = @kommune.latitude
      @map_lng = @kommune.longitude
      @map_zoom = 13
    end

    @categories = Category.all
  end

  def search_models(klass, params)
    case params[:filter]
    when nil, ''
      records = klass.order('created_at DESC')
    else
      records = klass.joins(:categories).where("categories.name = ?", params[:filter])
    end

    if @quarter
      records = records.within_quarter(@quarter_id)
    elsif @kommune
      records = records.within_kommune(@kommune_id)
    end
    records = records.page(params[:page]).per(25)
    records_map = records.where('visible = true')

    [records, records_map]
  end
end
