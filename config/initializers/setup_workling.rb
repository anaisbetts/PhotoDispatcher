Workling::Remote.dispatcher = Workling::Remote::Runners::SpawnRunner.new

# if Photo.count == 0
#   RAILS_DEFAULT_LOGGER.info "No known photos to display, scanning..."
#   PhotoCollectorWorker.async_collect
# end
