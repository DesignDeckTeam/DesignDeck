module ImagesHelper
  def render_designer_sample(version)
    if version.present?
      image_tag(version.image_from_designer.medium.url, class: "thumbnail")
    else
      image_tag("http://placehold.it/200x200&text=No Pic", class: "thumbnail")
    end
  end
end
