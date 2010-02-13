class EvernoteAction < MailAction
  def width; 1280; end
  def height; 1024; end

  def email_address(options = {})
    photo = options[:item]
    photo.user.settings[:evernote_email]
  end

  def friendly_name
    "Send to Evernote"
  end

  register_as_action
end
