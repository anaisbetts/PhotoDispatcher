module ImageHelper
  def fullimage_url(photo)
    url_for(:controller => 'image', :action => 'index', :id => photo.id)
  end

  def largethumbnail_url(photo)
    url_for(:controller => 'image', :action => 'largethumbnail', :id => photo.id)
  end

  def tinythumbnail_url(photo)
    url_for(:controller => 'image', :action => 'tinythumbnail', :id => photo.id)
  end
end
