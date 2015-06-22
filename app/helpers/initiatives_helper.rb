module InitiativesHelper
  def add_active_class(controller_name, action_name=nil, param_name=nil, param_value=nil)
    classes = 'button secondary small'
    if (params[:controller] == controller_name) && (action_name.nil? || (params[:action] == action_name)) &&
      (param_name.nil? || (params[param_name] == param_value))
      classes << " active"
    end
    return classes
  end

  def recent_initiatives
    @recent_initiatives ||= (@initiatives.try(:recent) || Initiative.recent)
  end
end
