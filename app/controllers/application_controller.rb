class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :sidebar
  #after_filter :store_location

  layout :layout_by_resource

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Sie haben leider keine Berechtigung diese Seite zu sehen"

    if user_signed_in?
      redirect_to root_url
    else
      session['user_return_to'] = request.fullpath
      redirect_to new_user_session_path
    end
  end

  # def store_location
  #   if request.fullpath != "/login" && request.fullpath != "/logout" && !request.xhr?
  #     session['user_return_to'] = request.fullpath
  #   end
  # end

  # def after_sign_in_path_for(resource)
  #   if params[:modal]
  #     url = request.env['HTTP_REFERER']
  #     # TODO: Sanitize the url
  #     # URI(url).host == params[:domain]
  #     url || root_path
  #   else
  #     session['user_return_to'] || super
  #   end
  # end

  def layout_by_resource
    if devise_controller?
      "layout_devise"
    elsif params[:controller] == "pages" && params[:action] == "start" or params[:controller] == "quarters" && params[:action] == "show"
      "start"
    else
      "application"
    end
  end

  def all_quarters
    @all_quarters ||= Quarter.all
  end
  helper_method :all_quarters

  def ensure_valid_recaptcha
    if !current_user
      if !verify_recaptcha
        redirect_to :back, alert: 'Der SPAM-Schutz Test wurde leider nicht bestanden.'
      end
    end
  end
end
