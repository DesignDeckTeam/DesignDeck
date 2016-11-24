class Designer::SamplesController < ApplicationController
 

  def show
  	@sample = Sample.find(params[:id])
    conversations = @sample.conversations
    @messages_array = []

    conversations.each do |conversation|
      message = conversation.messages.first

      return if message.blank?

      message_hash = {}
      message_hash[:note] = message.body
      message_hash[:x] = conversation.x_position_in_sample
      message_hash[:y] = conversation.y_position_in_sample
      @messages_array << message_hash  	
  	end
  end


  def index
  end

end
