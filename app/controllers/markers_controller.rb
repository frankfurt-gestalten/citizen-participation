class MarkersController < ApplicationController
  include LocationVariables

  def index
    constructions = Construction.current

    # Search according what is sent in params[:types],
    # input in view file must have name: types[] to be detected as array
    if params[:types]
      types = params[:types] & %w(initiative antraege construction)
    end

    if types.present?
      types.each do |type|
        klass = type == 'construction' ?
          Construction.current : type.camelize.constantize

        models_and_models_map = search_models(klass, params)

        instance_variable_set("@#{type.pluralize}", models_and_models_map[0])
        instance_variable_set("@#{type.pluralize}_map", models_and_models_map[1])
      end

    # Search all type of markers by default
    else
      @initiatives,   @initiatives_map   = search_models Initiative,    params
      @antraeges,     @antraeges_map     = search_models Antraege,      params
      @constructions, @constructions_map = search_models constructions, params
    end

    respond_to do |format|
      format.json do
        render :json =>
          json_for(
            @initiatives, @antraeges, @constructions,
            @map_lat, @map_lng, @map_zoom
          )
      end
    end
  end

  DATE_FORMAT = '%d.%m.%Y'

  private

  delegate :link_to, :escape_javascript, :truncate_html, :to => :view_context

  def json_for(initiatives, antraeges, constructions, lat, lon, zoom)
    {
      :initiatives => (initiatives.as_json || []).map do |initiative|
        initiative.merge({
          :popup => "<b>#{link_to initiative['title'], initiative_path(initiative)}</b>" +
          "<br><p>#{escape_javascript(truncate_html(initiative['content'].html_safe, :length => 50))}</p>" +
          "#{link_to 'Zur Initiative', initiative_path(initiative)}"
        })
      end,

      :antraeges => (antraeges.as_json || []).map do |antraege|
        antraege.merge({
          :popup => "#{link_to antraege['title'], antraege_path(antraege)}" +
          "<br>#{link_to 'Zur Rats-info', antraege_path(antraege)}"
        })
      end,

      :constructions => (constructions.as_json || []).map do |construction|
        construction.merge({
          :popup => "#{link_to construction['title'] + ' ' +
            "#{construction['start_date'].try(:strftime, DATE_FORMAT)} - " +
            "#{construction['end_date'].try(:strftime, DATE_FORMAT)}",
            construction_path(construction)}" +
          "<br>#{link_to 'Zur Baustelle', construction_path(construction)}"
        })
      end,

      # To center map
      :location => {:lat => lat, :lon => lon},
      :zoom => zoom
    }
  end
end
