class WelcomeController < ApplicationController
  acts_as_iphone_controller :test_mode => true

  def index
    @items = Photo.find(:all).map do |p|
      rel_path_param = p.relativepath.split('/')
      thumb_url = url_for(:controller => 'image', :action => 'tinythumbnail', :relativepath => rel_path_param)
      item = ListModel.new(nil, 
                           render_to_string(:partial => "tile", 
                                            :locals => { :image_url => thumb_url, :text => p.filename }),
                           url_for(:action => 'index', :controller => 'photos', :relativepath => rel_path_param))
    end
  end
end
