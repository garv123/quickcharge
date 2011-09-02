Given /^I am logged in$/ do 
  visit root_path
  stub_request(:get, "https://www.cobot.me/api/user").with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'OAuth c4c...4d4', 'User-Agent'=>'Ruby'}).to_return(status: 200, headers: {}, body: '{"admin_of":[{"space_link": "https://www.cobot.me/api/spaces/co-up"}]}')
  click_link "Sign in"
end

When /^I click "([^"]*)"$/ do |subdomain_link|
  click_link subdomain_link
end

Then /^I am signed out of the app$/ do
  page.should have_selector("*", :text => /You have been signed out/)
end

