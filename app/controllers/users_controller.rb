class UsersController < ApplicationController
    before_action :authenticate_user!
    
    def create
        @sign_up = User.new(configure_permitted_parameters)
        puts @sign_up.inspect
      if @sign_up.save
        UserMailer.registration_confirmation(@sign_up).deliver
        flash[:success] = "Please confirm your email address to continue"
        redirect_to root_url
      else
        flash[:error] = "Ooooppss, something went wrong!"
        redirect_to :back
      end
    end
  
    def index
        @users = User.includes(:profile)
      
       
    end
    
    
    def show
        # GET to /users/:id
        @user = User.find(params[:id])
    end
    
    def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to signin_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
    
  end
    
   
    
end    