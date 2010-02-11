class SessionsController < Clearance::SessionsController
  private
  def url_after_create
    photos_url
  end
end
