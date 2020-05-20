class UsersController < ApplicationController
    before_action :authenticate_user!
    
    def show
        # GET to /users/:id
        @user = User.find(params[:id])
    end    
    
end    