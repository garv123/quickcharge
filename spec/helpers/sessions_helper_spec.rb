require 'spec_helper'

describe SessionsHelper do
  describe "get_clean_subdomain_names(spaces)" do
    it "splits subdomain names from the hashes of URLs provided by cobot and puts them into an array" do
      test_contents = [
        {"space_link"=>"https://www.cobot.me/api/spaces/my-subdomain"},
        {"space_link"=>"https://www.cobot.me/api/spaces/test2"}]
      get_clean_subdomain_names(test_contents)
      @admin_of.should == ["my-subdomain", "test2"]
    end
  end
end
