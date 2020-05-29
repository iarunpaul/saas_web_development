class UsersController < ApplicationController
    before_action :authenticate_user!
    
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