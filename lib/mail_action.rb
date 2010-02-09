require 'actions_framework' 

class MailAction < Workling::Base
  def width
    640
  end

  def height
    480
  end

  def can_invoke?(item)
    true  ## TODO: Verify that ActionMailer works
  end

  def invoke(options = {})
    puts "Foobar"
    return false unless options[:item]
  end
end
