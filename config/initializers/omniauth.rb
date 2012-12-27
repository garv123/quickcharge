Rails.application.config.middleware.use OmniAuth::Builder do
  provider :cobot, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], scope: 'read write'
end
