module SessionsHelper

  def authenticate
    unless session[:token]
      session[:return_to] = request.fullpath
      redirect_to root_path, notice: "Please sign in to access this content."
    end
  end
  
  def get_clean_subdomain_names(spaces)
    @admin_of = []
    spaces.each do |value|
      # Extract clean subdomain names
      # First, split the space link URLs on /
      sub = value.to_s.split("/")
      # Next, remove extraneous punctuation
      # The replace for } in the next line is for clean matching in testing
      subdomain_value = sub[5].gsub /"|\>|}/, ''
      # Finally, put the subdomain names into an array for later comparison
      @admin_of << subdomain_value
    end
  end
  
end
