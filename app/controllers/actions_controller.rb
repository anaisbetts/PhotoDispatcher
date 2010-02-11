class ActionsController < ApplicationController
  before_filter :authenticate

  def invoke
    redirect_to '/'
  end

private
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
