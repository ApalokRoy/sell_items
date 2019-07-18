Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '287486472070349', '8e4f4a55a4dec74f907bc66c0bc88fcf'
  provider :google_oauth2, 
  '845097422285-keq7l5fgssqfn6qag6m3h8q976cu1t5m.apps.googleusercontent.com',
  'cezj4VjEZTsKu4WPnu6XZVDz'

end