class PhotosController < ApplicationController
  before_filter :authenticate
  before_filter :initial_photo_scan

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

  def initial_photo_scan
    if Photo.count == 0
      logger.info "No known photos to display, scanning '#{current_user.import_path}'..."
      PhotoCollectorWorker.async_collect(:root_folder => current_user.import_path, :user_id => current_user.id)
    end

    true
  end
end
