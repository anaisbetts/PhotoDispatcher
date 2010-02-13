module PhotoDispatcher
  class << self
    def scale_image(input_path, output_path, width, height)
      f = Pathname.new(input_file)
      temp_out = Tempfile.new("pcw")

      command = "gm convert -resize #{[width, height].join 'x'} \"#{f.to_s}\" \"#{temp_out.path}\""
      logger.debug "Running '#{command}'"
      `#{command}`
      raise "Failed to create image: gm returned #{$?.exitstatus}" unless $?.success?
      logger.debug "Moving file to '#{output_path}'"

      FileUtils.move temp_out.path, output_path

      output_path
    end
    
  private

    def logger
      RAILS_DEFAULT_LOGGER
    end
  end
end
