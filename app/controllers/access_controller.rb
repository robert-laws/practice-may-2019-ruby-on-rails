class AccessController < ApplicationController
  layout 'admin'

  # before_action :confirm_logged_in, except: [:login, :attempt_login, :logout]
  skip_before_action :confirm_logged_in, only: [:login, :attempt_login, :logout]

  def menu
    # display text & links
  end

  def login
    # login form
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = SiteUser.where(username: params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "You are now logged in."
      redirect_to(admin_path)
    else
      flash.now[:notice] = "Invalid username/password combination"
      render 'login'
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(login_path)
  end

  # private

  # def confirm_logged_in
  #   unless session[:user_id]
  #     flash[:notice] = "Please Login"
  #     redirect_to(login_path)
  #   end
  # end
end
