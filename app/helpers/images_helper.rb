module ImagesHelper
  def render_sample(sample)
    if sample.image.present?
      image_tag(sample.image.medium.url, class: "thumbnail", style: "width:100%;")
    else
      image_tag("http://placehold.it/200x200&text=No Pic", class: "thumbnail", style: "width:100%;")
    end
  end
end
