class User < ActiveRecord::Base
  include Clearance::User
  has_many :photos

  before_save :initialize_import_path
  before_save :settings_to_yaml

  def settings
    @settings = (settings_yaml ? YAML.load(settings_yaml) : {})
  end

  def settings=(value)
    puts "WHAT THE FUCK 2"
    @settings = value
    self.settings_yaml = value.to_yaml
  end

private

  def initialize_import_path
    self.import_path = PHOTO_IMPORT_FOLDER
    true
  end

  def settings_to_yaml
    return true unless @settings
    puts "WHAT THE FUCK"
    self.settings_yaml = @settings.to_yaml
    true
  end

  class << self
    def photo_import_folder
      return PHOTO_IMPORT_FOLDER
    end
  end

end
