Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.FB_APP_ID, Rails.application.secrets.FB_APP_SECRET
  provider :google_oauth2, Rails.application.secrets.GOOGLE_KEY, Rails.application.secrets.GOOGLE_SECRET
end