class DesignersController < ApplicationController

  before_action :authenticate_user!
  before_action :get_designer_by_token


  def show
  end

  def edit
  end

  def update
  	if @designer.update(user_params)
  		redirect_to designer_path(@designer.token)
  	else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :designer_intro, {designer_products: []}, :talent)
  end

  def get_designer_by_token
  	@designer = User.find_by(token: params[:id])
  end


end
