class Designer::ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :designer_required

  def index
    @users = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
  
    if @user.update(user_params)
      redirect_to designer_profiles_path
    else
      render :edit
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :designer_intro, {designer_products: []})
  end
end
