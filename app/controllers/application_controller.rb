class ApplicationController < ActionController::Base
  include Clearance::Authentication

  before_filter :hack_sign_in

  helper :all

  protect_from_forgery

  include HoptoadNotifier::Catcher

private
  def hack_sign_in
    # Sign us in to the first user, always
    return true if signed_in?
    return true unless User.count > 0
    sign_in(User.find(:all)[0])

    true
  end
end
