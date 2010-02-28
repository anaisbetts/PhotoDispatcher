class PhotosController < ApplicationController
  before_filter :authenticate
  before_filter :initiate_photo_scan

  acts_as_iphone_controller :test_mode => true

  def index
    @items = Photo.find_all_by_user_id(current_user.id, :all).map do |p|
      item = ListModel.new(nil, 
                           render_to_string(:partial => "tile", 
                                            :locals => { :item => p}),
                           user_photo_url(current_user, p))
    end
  end

  def show
    @item = Photo.find_by_id(params[:id], :limit => 1)
    raise "Denied!" unless @item.user_id == current_user.id
    @actions = ActionsFramework.actions.select{|x| ActionsFramework[x].can_invoke? @item}.map{|x| ActionsFramework[x]}
  end

  def destroy
    item = Photo.find_by_id(params[:id], :limit => 1)
    raise "Denied!" unless @item.user_id == current_user.id
    item.destroy
    
    redirect_to :action => 'index'
  end

private

  def initiate_photo_scan
    if scan_for_photos?
      logger.info "No photos or haven't checked recently, scanning '#{current_user.import_path}'..."
      PhotoCollectorWorker.async_collect(:root_folder => current_user.import_path, :user_id => current_user.id)
    end

    true
  end

  def scan_for_photos?
    return false unless current_user

   (current_user.photos.count == 0 or current_user.last_scanned == nil or current_user.last_scanned < 10.minutes.ago)
  end
end
