ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'action_view/test_case'

Mocha::Configuration.warn_when(:stubbing_non_existent_method)
Mocha::Configuration.warn_when(:stubbing_non_public_method)

class ActiveSupport::TestCase

  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false

  def logger
    RAILS_DEFAULT_LOGGER
  end
end

class ActionView::TestCase
  class TestController < ActionController::Base
    attr_accessor :request, :response, :params
 
    def initialize
      @request = ActionController::TestRequest.new
      @response = ActionController::TestResponse.new
      
      # TestCase doesn't have context of a current url so cheat a bit
      @params = {}
      send(:initialize_current_url)
    end
  end
end

class ActionController::TestCase
  include ActionView::Helpers::RecordIdentificationHelper
end

if true ## Change this when debugging tests
  class Workling::Base
    @@logger = Logger.new(STDERR)
  end

  class ActiveSupport::TestCase
    @@debug_logger = Logger.new(STDERR)
    def logger
      @@debug_logger
    end
  end
end
