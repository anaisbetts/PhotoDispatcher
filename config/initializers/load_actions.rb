require 'actions_framework'

Dir.glob(File.join(RAILS_ROOT, 'app', 'actions', '**', '*.rb')).each {|x| require x}
