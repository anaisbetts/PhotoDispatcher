require 'test_helper'
require 'mocha'

class PhotoWorkerTest < ActiveSupport::TestCase

  test "import fixtures folder" do
    pcw = PhotoCollectorWorker.new
    thumb_dir = "/tmp/#{Digest::SHA1.hexdigest(pcw.hash.to_s)}"

    begin
      FileUtils.mkdir thumb_dir
      root_dir = fixtures_root_dir


      assert pcw.collect(:root_folder => root_dir, :thumb_root_path => thumb_dir, 
                         :errors_are_fatal => true)

      fixtures_dir_p = Pathname.new(fixtures_root_dir)
      Photo.stubs(:photo_import_folder).returns(fixtures_dir_p.realpath.to_s)
      files = []
      fixtures_dir_p.find {|f| next unless f.file? and f.to_s.ends_with?('JPG'); files << f}

      logger.debug Photo.count
      logger.debug files
      assert Photo.count == files.count
    ensure
      FileUtils.rm_rf thumb_dir
    end
  end

  def fixtures_root_dir
    File.join(File.dirname(__FILE__), "..", "fixtures", "PhotoImportTest")
  end
end
