class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :required_is_admin

  def index
    @users = User.where(:role => "设计师").order("is_designer ASC")    
  end

  def approve_designer
    @user = User.find(params[:user_id])
    @user.approve!
    redirect_to :back
  end

  def required_is_admin
    if !current_user.admin?
      flash[:alert] = 'You are not admin'
      redirect_to root_path
    end
  end
end
