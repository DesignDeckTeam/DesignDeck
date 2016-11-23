class Account::SamplesController < ApplicationController
  def show
  end

  def edit
  	@sample = Sample.find(params[:id])
  end
end
