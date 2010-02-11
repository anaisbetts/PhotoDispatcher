class User < ActiveRecord::Base
  include Clearance::User
  has_many :photos

  before_save :initialize_import_path

private

  def initialize_import_path
    # HACK: This is a constant for now
    logger.fatal "WHAT THE FUCK"
    self.import_path = PHOTO_IMPORT_FOLDER
  end

  class << self
    def photo_import_folder
      return PHOTO_IMPORT_FOLDER
    end
  end

end
