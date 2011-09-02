When /^I sign in with OmniAuth/ do
  visit root_path
  stub_request(:get, "https://www.cobot.me/api/user").with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'OAuth c4c...4d4', 'User-Agent'=>'Ruby'}).to_return(status: 200, headers: {}, body: '{"admin_of":[{"space_link": "https://www.cobot.me/api/spaces/co-up"}]}')
  click_link "Sign in"
end

When /^an error occurs with OmniAuth login$/ do
  visit auth_failure_path
end

Then /^I should be logged in$/ do
  page.should have_selector("*", :text => /Subdomains/i)
end

Then /^I should see an error message$/ do
  page.should have_selector("*", :text => /Sorry, something went wrong/i)
end
