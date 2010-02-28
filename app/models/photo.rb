PhotoThumbnailSizes = {
  :tinythumbnail => [32, 21],
  :largethumbnail => [300, 200],
}

class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :actionentries

  validates_uniqueness_of :relativepath
  validates_presence_of :tinythumbnail
  validates_presence_of :largethumbnail
  validate :relativepath_doesnt_escape_photo_dir

  before_destroy :delete_associated_files


  ##
  ## Validators
  ##

  def relativepath_doesnt_escape_photo_dir
    errors.add_to_base("absolutepath '#{relativepath}' is outside import folder") unless absolutepath
  end


  ##
  ## Helper properties
  ##

  def absolutepath
    pn = nil
    begin
      pn = Pathname.new(File.join(photo_import_folder, relativepath)).realpath
      raise "Fail" unless pn.exist? and pn.to_s.starts_with? photo_import_folder
    rescue
      logger.error "absolutepath '#{relativepath}' is outside import folder: #{$!.message}\n#{$!.backtrace}"
      logger.debug "expected is '#{photo_import_folder}'"
      return nil
    end

    pn.to_s
  end

  def filename
    relativepath.gsub /^.*\/([^\/]*)$/, '\1'
  end

  def exif_data
    @exif_data || (@exif_data = YAML.load(exif_data_yaml))
  end

  def lat_lng
    return nil unless exif_data[:gps_latitude] and exif_data[:gps_longitude]

    # Exifr returns this as a tuple of Rationals, like 50 deg, 30', 24"
    # Convert these to decimal values that GMaps understands
    [exif_data[:gps_latitude], exif_data[:gps_longitude]].zip([exif_data[:gps_latitude_ref], exif_data[:gps_longitude_ref]]).map do |x, ref|
      (x[0] + (x[1] / 60) + (x[2] / 3600)).to_f * (['N', 'E'].include?(ref) ? 1.0 : -1.0)
    end
  end

  def taken_at_time
    exif_data[:date_time]
  end


  ##
  ## Callbacks
  ##

  def delete_associated_files
    # Blow away our thumbnails first
    PhotoThumbnailSizes.keys.map{|x| self.send(x)}.each{|x| FileUtils.rm x}
    FileUtils.rm absolutepath
  end

  def photo_import_folder
    return user.import_path
  end

  ##
  ## Class Methods
  ##

  class << self
    def thumbnail_path(type, enclosing_dir, full_image_path, image_cache_dir = nil)
      path_hash = Digest::SHA1.hexdigest(enclosing_dir)
      contents_hash = Digest::SHA1.file(full_image_path).hexdigest

      cachedir = image_cache_dir || photo_thumbnail_folder
      raise "Thumbnail folder not set, set it in config/environments/*" unless cachedir
      File.join(cachedir, [path_hash, contents_hash, type].join('_')) + ".jpg"
    end

    def photo_thumbnail_folder
      return PHOTO_THUMBNAIL_FOLDER
    end
  end
end
