class Account::SamplesController < ApplicationController


  require 'json'

  def show
  end

  def edit
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

  def update
  	@sample = Sample.find(params[:id])
    @sample.conversations.delete_all

  	p = params[:data_value]
    
    if p == "[]"
      redirect_to account_version_path(@sample.version)
      return
    end
    
    p.gsub!(/\"/, "").tr!("[", "").tr!("]", "")
    comment_array = p.split("},")

    order = @sample.version.stage.order
    stage = @sample.version.stage

    # binding.pry
    comment_array.each do |comment|
      comment_hash = to_hash(comment)
      puts comment_hash["text"]
      puts comment_hash["left"]
      puts comment_hash["top"]
      current_user.send_message(order.designer,
                                comment_hash["text"],                                
                                "stage#{stage.id} sample#{@sample.id}",
                                @sample,
                                comment_hash["left"],
                                comment_hash["top"])
    end
  	
  	redirect_to account_order_path(@sample.version.stage.order)

  end


  private

  def to_hash(string)
    if string.first == "{"
      string[0] = ""
    end
    if string.last == "}"
      string[-1] = ""
    end
    h = {}
    string.split(',').each do |substr|
      ary = substr.strip.split(':')
      h[ary.first.tr('"','')] = ary.last.tr('"','')
    end
    return h
  end



end
