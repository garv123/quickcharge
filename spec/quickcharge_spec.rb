require 'spec_helper'

describe "Quickcharge App" do
  include Rack::Test::Methods
  
  def app
    Sinatra::Application
  end
  
  it "should response with a 302 response code" do
    get "/login"
    
    last_response.status.should == 302
  end
  
  it "should get an access token" do
    stub_request(:post, 'https://www.cobot.me/oauth2/access_token').to_return(body: '{"token":"something"}')
    
    get "/callback", code: '123'
    
    WebMock.should have_requested(:post, 'https://www.cobot.me/oauth2/access_token').with(body: /code=123/)
  end
  
  it "should request user endpoint, space endpoints and respond with list of spaces" do
    stub_request(:get, 'https://www.cobot.me/api/user?oauth_token=').to_return(body: '{"admin_of":[{"space_link": "https://www.cobot.me/api/spaces/co-up"}]}')
    stub_request(:get, 'https://www.cobot.me/api/spaces/co-up?oauth_token=').to_return(body: '{"id":"space-co-up","name":"co.up"}')
    
    get "/spaces"
    
    WebMock.should have_requested(:get, 'https://www.cobot.me/api/user?oauth_token=')
    WebMock.should have_requested(:get, 'https://www.cobot.me/api/spaces/co-up?oauth_token=')
    
    last_response.status.should == 200
  end
  
  it "should get the memberships of a space" do
    stub_request(:get, 'https://co-up.cobot.me/api/memberships?oauth_token=').to_return(body: '[{"id":"matthiasjakel", "address":{"name":"Matthias Jakel"}}]')
    
    get "/spaces/space-co-up"
    
    WebMock.should have_requested(:get, 'https://co-up.cobot.me/api/memberships?oauth_token=')
    
    last_response.status.should == 200
  end
  
  it "should make a charge request" do
    stub_request(:post, 'https://co-up.cobot.me/api/memberships/1/charges').to_return(status: 201)
    
    post "/spaces/space-co-up/charge/1", description: "extra charge for beverage", amount: "15"
    
    last_response.status.should == 201
    body = JSON.parse(last_response.body)
    body['message'].should == "Charged successfully."
  end
  
  it "should try an charge request and should response with an error message" do
    stub_request(:post, 'https://co-up.cobot.me/api/memberships/1/charges').to_return(status: 400, body: '{"amount": "has to be a number"}')
    
    post "/spaces/space-co-up/charge/1", description: "extra charge for beverage", amount: "test"
    
    last_response.status.should == 400
    body = JSON.parse(last_response.body)
    body['message'].should == "Charge failed."
    body['errors'][0].should == "amount has to be a number"
  end
end

