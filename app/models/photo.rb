class Photo < ActiveRecord::Base
  validates_uniqueness_of :relativepath
  validate :relativepath_doesnt_escape_photo_dir

  def relativepath_doesnt_escape_photo_dir
    errors.add_to_base("absolutepath '#{relativepath}' is outside import folder") unless absolutepath
  end

  def absolutepath
    pn = nil
    begin
      pn = Pathname.new(File.join(PHOTO_IMPORT_FOLDER, relativepath)).realpath
      raise "Fail" unless pn.exist? and pn.to_s.starts_with? PHOTO_IMPORT_FOLDER
    rescue
      logger.error "absolutepath '#{relativepath}' is outside import folder"
      return nil
    end

    pn.to_s
  end

  def filename
    relativepath.gsub /^.*\/([^\/]*)$/, '\1'
  end

  class << self
    def thumbnail_path(type, enclosing_dir, full_image_path, image_cache_dir = nil)
      path_hash = Digest::SHA1.hexdigest(enclosing_dir)
      contents_hash = Digest::SHA1.file(full_image_path).hexdigest

      cachedir = image_cache_dir || PHOTO_THUMBNAIL_FOLDER
      raise "Thumbnail folder not set, set it in config/environments/*" unless cachedir
      File.join(cachedir, [path_hash, contents_hash, type].join('_')) + ".jpg"
    end
  end
end
