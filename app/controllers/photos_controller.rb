class PhotosController < ApplicationController
  acts_as_iphone_controller :test_mode => true

  def index
    @items = Photo.find(:all).map do |p|
      item = ListModel.new(nil, 
                           render_to_string(:partial => "tile", 
                                            :locals => { :item => p}),
                           photo_url(p))
    end
  end

  def show
    @item = Photo.find_by_id(params[:id], :limit => 1)
    @photos_url = photos_url
    @filename = @item.filename
  end
end
