# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => "OmgSession",
  :secret => "40596364e70d55e972530e029d4f3693e2a450ce1b9fa8c740fed6038108732524cd2d9e85512ffc82b795d5efaf0289a39cdec0eb2773e180b49e02bbf8626c"
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
