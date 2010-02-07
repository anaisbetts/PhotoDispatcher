class PhotoController < ApplicationController
  acts_as_iphone_controller :test_mode => true

  def index
  end
end
