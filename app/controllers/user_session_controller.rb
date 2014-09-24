class UserSessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    params[:user][:login].downcase!
    super
  end

end
