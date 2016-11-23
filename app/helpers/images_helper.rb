module ImagesHelper

  def render_sample(sample)
    if sample.image.present?
      image_tag(sample.image.medium.url, class: "thumbnail", style: "width:100%;")
    else
      image_tag("http://placehold.it/200x200&text=No Pic", class: "thumbnail", style: "width:100%;")
    end
  end

  
  def render_sample_with_link(sample)
    if sample.image.present?
      link_to (image_tag sample.image.medium.url, class: "thumbnail", style: "width:100%;"), edit_account_sample_path(sample)       
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

end
