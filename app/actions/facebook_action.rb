class FacebookAction < MailAction
  def width; 1024; end
  def height; 768; end

  def email_address(options = {})
    photo = options[:item]
    photo.user.settings[:facebook_email]
  end

  def friendly_name
    "Upload to Facebook"
  end

  register_as_action
end
