module ApplicationHelper
  def client
    @client ||= OAuth2::Client.new(
      ENV['CLIENT_ID'],
      ENV['CLIENT_SECRET'],
      site: 'https://www.cobot.me',
      authorize_path: '/oauth2/authorize',
      access_token_path: '/oauth2/access_token',
      raise_errors: false
    )
  end

  def api
    @api ||= OAuth2::AccessToken.new(client, access_token)
    @api
  end

  def access_token(access_token=nil)
    session[:token]
  end

  def user(cobot_user=nil)
    @user ||= api.get('https://www.cobot.me/api/user')
  end

end
