module ImagesHelper

  def render_sample(sample)
    if sample.image.present?
      image_tag(sample.image.medium.url, class: "thumbnail", style: "width:100%;")
    else
      image_tag("http://placehold.it/200x200&text=No Pic", class: "thumbnail", style: "width:100%;")
    end
  end


  def render_note_indicator(sample)
    if sample.conversations.any?                       
      link_to "!", "#", class: "btn btn-danger noted-indicator text-center"
    end
  end
  
  def render_sample_with_link(sample)
    if sample.image.present?
      if current_user.is_user?
        if sample.version.stage.order.drafts_submitted?
          link_to (image_tag sample.image.medium.url, class: "thumbnail", style: "width:100%;"), account_sample_path(sample)
        else
          link_to (image_tag sample.image.medium.url, class: "thumbnail", style: "width:100%;"), edit_account_sample_path(sample)       
        end
      else
        link_to (image_tag sample.image.medium.url, class: "thumbnail", style: "width:100%;"), designer_sample_path(sample)  
      end
    else
      image_tag("http://placehold.it/200x200&text=No Pic", class: "thumbnail", style: "width:100%;")
    end
  end  

  def render_version_of_sample(sample)
    if sample.image.present?
      link_to (image_tag sample.image.medium.url, class: "thumbnail", style: "width:100%;"), account_version_path(sample.version)       
    else
      image_tag("http://placehold.it/200x200&text=No Pic", class: "thumbnail", style: "width:100%;")
    end
  end    	

  # def render_sample_with_conversations(sample)
  #   if sample.image.present?
  #     conversations = sample.conversations
  #     messages = Mailboxer::Message.find(conversations.ids)
      
  #     # link_to (image_tag sample.image.medium.url, class: "thumbnail", style: "width:100%;"), account_version_path(sample.version)       

  #   else
  #     image_tag("http://placehold.it/200x200&text=No Pic", class: "thumbnail", style: "width:100%;")
  #   end

end
