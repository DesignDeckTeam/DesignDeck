class Account::SamplesController < ApplicationController
  def show
  end

  def edit
  	@sample = Sample.find(params[:id])
  end

  def update
  	@sample = Sample.find(params[:id])
  	p = params[:data_value]
  	comment_array = p.gsub!(/\"/, "").tr!("[", "").tr!("]", "")


  	# binding.pry
  	redirect_to account_version_path(@sample.version)
  end




end
