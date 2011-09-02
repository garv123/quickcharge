require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the PagesHelper. For example:
#
# describe PagesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe SessionsHelper do
  describe "get_clean_subdomain_names(spaces)" do
    it "splits subdomain names from the hashes of URLs provided by cobot and puts them into an array" do
      test_contents = [
        {"space_link"=>"https://www.cobot.me/api/spaces/my_subdomain"},
        {"space_link"=>"https://www.cobot.me/api/spaces/test2"}]
      get_clean_subdomain_names(test_contents)
      @admin_of.should == ["my_subdomain", "test2"]
    end
  end
end
