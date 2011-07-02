require 'sinatra'
require 'oauth2'
require 'json'
require 'erb'

enable :sessions
set environment: :development

def client
  @client ||= OAuth2::Client.new(
    '225ad46130533514994aa60351d5d9e4',
    'c904ba0b74b1d4c6949f846468913d7aa26f163cc46cb687b4e82a036e988e1a',
    site: 'https://www.cobot.me',
    authorize_path: '/oauth2/authorize',
    access_token_path: '/oauth2/access_token',
    parse_json: true,
    raise_errors: false
  )
end

def api
  @api ||= OAuth2::AccessToken.new(client, token)
end

def token(access_token=nil)
  session[:token] ||= access_token
end

def user(cobot_user=nil)
  @user ||= api.get('https://www.cobot.me/api/user')
end


get '/' do
  erb :index
end


get '/login' do
  redirect client.web_server.authorize_url(redirect_uri: 'http://localhost:4567/callback', scope: 'read write')
end


get '/callback' do
  token client.web_server.get_access_token(params[:code], redirect_uri: 'http://localhost:4567/callback').token
  redirect to('/spaces')
end


get '/spaces' do
  @spaces = user['admin_of'].map do |space|
    api.get(space['space_link'])
  end
  
  erb :space_index
end


get '/spaces/:space_id' do
  @space = params[:space_id].sub(/space-/, '')
  @memberships = api.get("https://#{@space}.cobot.me/api/memberships")
  erb :space_show
end


post '/spaces/:space_id/charge/:membership_id' do
  @space = params[:space_id].sub(/space-/, '')
  
  api_response = api.post("https://#{@space}.cobot.me/api/memberships/#{params[:membership_id]}/charges", {description: params[:description], amount: params[:amount].to_i})
    
  unless api_response.status == 201
    response = {errors: [], message: "Charge failed."}
    
    api_response.each do |key, value|
      response[:errors] << key + ' ' + value
    end
    
    response.to_json
  else
    {message: "Charged successfully."}.to_json
  end
end


