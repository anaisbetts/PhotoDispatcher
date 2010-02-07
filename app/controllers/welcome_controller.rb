class WelcomeController < ApplicationController
  acts_as_iphone_controller :test_mode => true

  def index
    item = ListModel.new(nil, 
                         render_to_string(:partial => "tile", 
                                          :locals => { :image_url => "http://knowyourmeme.com/i/984/original/1238805246000.jpg" }),
                        "http://www.google.com")
    @items = [item]
  end
end
