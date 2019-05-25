class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :confirm_logged_in

  private

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please Login"
      redirect_to(login_path)
    end
  end
end
