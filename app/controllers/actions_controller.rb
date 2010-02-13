class ActionsController < ApplicationController
  before_filter :authenticate

  def invoke
    photo = nil; action = nil
    redirect_to '/' unless (photo = photo_from_id) and (photo.user_id == current_user.id) and (action = action_from_name)

    logger.debug "Running #{action.action_name} on #{photo.id}..."
    ActionWorker.async_invoke(:item => photo, :action => action)
    redirect_to user_photos_url(photo.user)
  end

private
  def photo_from_relativepath
    relativepath = params[:relativepath].join('/')
    p = Photo.find_by_relativepath(relativepath, :limit => 1)
    raise "Not found" unless p

    p
  end

  def photo_from_id
    p = Photo.find_by_id(params[:id], :limit => 1)
  end

  def action_from_name
    ActionsFramework[params[:name].to_sym]
  end
end
