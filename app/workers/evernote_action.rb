require 'mail_action'

class EvernoteAction < MailAction
  def email_address
    "foobar@baz.com"
  end

  def friendly_name
    "Send to Evernote"
  end

  register_as_action
end
