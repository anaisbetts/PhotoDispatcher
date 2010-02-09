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
      @actions_list[klass.name.downcase.gsub(/action$/, '').to_sym] = instance
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
    end
  end
end
