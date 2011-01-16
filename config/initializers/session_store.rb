# Be sure to restart your server when you modify this file.

AjaxUpload::Application.config.session_store :cookie_store, :key => '_ajax-upload_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# AjaxUpload::Application.config.session_store :active_record_store

#ADD THIS
Rails.application.config.middleware.insert_before(
  ActionDispatch::Session::CookieStore,
  FlashSessionCookieMiddleware,
  Rails.application.config.session_options[:key]
)