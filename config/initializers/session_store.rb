# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wrug-celerity-app_session',
  :secret      => 'd4b727a13e5255127d66e5d36ebcbfd1fee0e5ed6f58dfddf0bccd460fd0a9f0021093d5d360fda428ed58173ff5a799356be71576aa80d88e396989b20b4633'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
