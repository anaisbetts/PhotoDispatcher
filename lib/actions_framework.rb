require 'utility'

class ActionsFramework
  class << self
    def actions
      @actions_list.keys
    end

    def [](k)
      @actions_list[k]
    end

    def register_action(klass)
      instance = klass.new
      [:friendly_name, :can_invoke?, :invoke].each do |x|
        puts "Actions must have #{x} defined" unless instance.respond_to?(x)
      end

      @actions_list ||= {}
      @actions_list[action_name(instance)] = instance
    end

    def action_name(instance)
      instance.class.name.downcase.gsub(/action$/, '').to_sym
    end
  end
end

class Class
  def register_as_action
    instance_eval do
      ActionsFramework.register_action(self)
    end

    class_eval do
      def async_invoke(options = {})
        self.class.send(:async_invoke, options)
      end

      def action_name
        ActionsFramework.action_name self 
      end
    end
  end
end

class MailAction
  def width
    640
  end

  def height
    480
  end

  def create_thumbnail(input_file)
      temp_out = Tempfile.new("pcw")
      PhotoDispatcher.scale_image(input_file, temp_out, width, height)
  end

  def can_invoke?(options = {})
    true  ## TODO: Verify that ActionMailer works
  end

  def invoke(options = {})
    photo = nil
    return false unless (photo = options[:item])

    mail = nil
    action = self
    mail = Mail.new do
      from DO_NOT_REPLY
      to action.email_address(options)
      subject photo.relativepath
      add_file({:filename => photo.filename, :content => File.read(photo.absolutepath)})
    end

    mail.deliver!
  end

  class << self
    def logger
      RAILS_DEFAULT_LOGGER
    end
  end
end
