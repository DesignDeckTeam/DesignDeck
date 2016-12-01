class FaqsController < ApplicationController

  def index
   @faqs = Faq.all
  end

  def show
    @faq = Faq.find(params[:id])
  end

  def new
    @faq = Faq.new
  end

  def create
    @faq = Faq.new(faq_params)
    @faq.save

     redirect_to faqs_path
   end

  def faq_params
   params.require(:faq).permit(:title, :description)
 end
end
