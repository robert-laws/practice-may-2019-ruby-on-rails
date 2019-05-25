class SiteUsersController < ApplicationController

  layout 'admin'

  def index
    @site_users = SiteUser.all
  end

  def show
    @site_user = SiteUser.find(params[:id])
  end

  def new
    @site_user = SiteUser.new
  end

  def create
    @site_user = SiteUser.new(site_user_params)

    if @site_user.save
      flash[:notice] = "New site user has been created."
      redirect_to site_user_path(@site_user)
    else
      render 'new'
    end
  end

  def edit
    @site_user = SiteUser.find(params[:id])
  end

  def update
    @site_user = SiteUser.find(params[:id])

    if @site_user.update_attributes(site_user_params)
      flash[:notice] = "The site user has been updated."
      redirect_to site_user_path(@site_user)
    else
      render 'edit'
    end
  end

  def delete
    @site_user = SiteUser.find(params[:id])
  end

  def destroy
    @site_user = SiteUser.find(params[:id])
    @site_user.destroy

    flash[:notice] = "The user - #{@site_user.username} - was destroyed successfully."
    redirect_to(site_users_path)
  end

  private

  def site_user_params
    params.require(:site_user).permit(:first_name, :last_name, :username, :hashed_password)
  end
end
