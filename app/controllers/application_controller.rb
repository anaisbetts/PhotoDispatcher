class ApplicationController < ActionController::Base
  before_filter :initial_photo_scan

  helper :all

  protect_from_forgery

  include HoptoadNotifier::Catcher

private
  def initial_photo_scan
    if Photo.count == 0
      RAILS_DEFAULT_LOGGER.info "No known photos to display, scanning..."
      PhotoCollectorWorker.async_collect
    end

    true
  end
end
