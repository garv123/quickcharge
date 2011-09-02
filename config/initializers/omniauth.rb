Rails.application.config.middleware.use OmniAuth::Builder do
  provider :Cobot, ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
end

