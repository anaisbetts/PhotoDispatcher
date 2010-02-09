class ImageController < ApplicationController
  def index
    p = photo_from_id
    send_image p.absolutepath
  end

  def largethumbnail
    p = photo_from_id
    send_image p.largethumbnail
  end

  def tinythumbnail
    p = photo_from_id
    send_image p.tinythumbnail
  end

private
  def send_image(path)
    send_file path, :type => 'image/jpeg', :disposition => 'inline'
  end

  def photo_from_relativepath()
    relativepath = params[:relativepath].join('/')
    p = Photo.find_by_relativepath(relativepath, :limit => 1)
    raise "Not found" unless p

    p
  end

  def photo_from_id()
    p = Photo.find_by_id(params[:id], :limit => 1)
  end
end
