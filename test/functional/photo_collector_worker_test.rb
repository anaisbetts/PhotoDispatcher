require 'test_helper'

class PhotoWorkerTest < ActiveSupport::TestCase

  test "import fixtures folder" do
    pcw = PhotoCollectorWorker.new
    thumb_dir = "/tmp/#{Digest::SHA1.hexdigest(pcw.hash.to_s)}"

    begin
      FileUtils.mkdir thumb_dir
      root_dir = fixtures_root_dir

      assert pcw.collect(:root_folder => root_dir, :thumb_root_path => thumb_dir, 
                         :errors_are_fatal => true)

      fixtures_dir_p = Pathname.new fixtures_root_dir
      Photo.find(:all).each do |p|
        logger.debug p
      end

    ensure
      #FileUtils.rm_rf thumb_dir
    end
  end

  def fixtures_root_dir
    File.join(File.dirname(__FILE__), "..", "fixtures", "PhotoImportTest")
  end
end
