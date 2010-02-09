class Photo < ActiveRecord::Base
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
