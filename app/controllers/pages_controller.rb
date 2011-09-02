class PagesController < ApplicationController

  before_filter :authenticate, except: :index
  before_filter :check_if_logged_in, only: :index
  before_filter :check_if_owner, only: [:show, :charge]

  def index
  end

  def spaces
    @spaces = session[:admin_of]
  end

  def show
    @subdomain = params[:id]
    memberships = api.get("https://#{@subdomain}.cobot.me/api/memberships")
    @members = JSON.parse(memberships.body)
  end

  def charge
    subdomain = params[:id]
    member_id = params[:membership]
    @charge = api.post("https://#{subdomain}.cobot.me/api/memberships/#{member_id}/charges", 
                       params: { 'description' => params[:description], 'amount' => params[:amount] })

    if @charge.headers['status'] == "422"
      flash[:error] = "All fields must be filled in."
    elsif @charge.headers['status'] == "201"
      flash[:success] = "Charges successful."
    else
      flash[:notice] = "Unrecognized server response. You may have forgotten to select a member. 
                        If the problem persits, please contact cobot support."
    end
    redirect_to(space_path(params[:id]))
  end

  private

    def check_if_owner
      unless session[:admin_of].include?(params[:id])
        redirect_to(spaces_path, notice: "You do not have admin privileges for that subdomain.")
      end
    end

    def check_if_logged_in
      # Can't go to signin page if already signed in
      if session[:token]
        redirect_to spaces_path
      end
    end

end
