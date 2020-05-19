class UsersController < ApplicationController
    
    def show
        # GET to /users/:id
        @user = User.find(params[:id])
    end    
    
end    