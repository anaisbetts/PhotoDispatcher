class WelcomeController < ApplicationController
  acts_as_iphone_controller :test_mode => true

  def index
    item = ListItem.new
    item.url = "http://www.google.com"
    item.caption = render_to_string(:partial => "tile", :locals => { :image_url => "http://knowyourmeme.com/i/984/original/1238805246000.jpg" })
    @items = [item]
  end
end

class ListItem
  attr_accessor :url
  attr_accessor :caption
end
