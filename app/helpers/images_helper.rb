module ImagesHelper
  def render_sample(sample)
    if sample.present?
      image_tag(sample.image.medium.url, class: "thumbnail")
    else
      image_tag("http://placehold.it/200x200&text=No Pic", class: "thumbnail")
    end
  end
end
