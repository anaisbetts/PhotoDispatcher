class TumblrAction < MailAction
  def width; 1280; end
  def height; 1024; end

  def email_address(options = {})
    photo = options[:item]
    photo.user.settings[:tumblr_email]
  end

  def friendly_name
    "Upload to Tumblr"
  end

  register_as_action
end
