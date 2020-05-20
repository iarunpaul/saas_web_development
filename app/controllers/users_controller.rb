class UsersController < ApplicationController
    before_action :authenticate_user!
    
    def index
        
    end
    
    def show
        # GET to /users/:id
        @user = User.find(params[:id])
    end    
    
end    