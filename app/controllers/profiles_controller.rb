class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :current_user_only
    # GET to /users/:user_id/profile/new
    def new
        #Render blank profile create form
        @profile = Profile.new
    end 
    
    # POST request to /users/:user_id/profile
    def create
        # Ensure that we have the user who is filling out the form
        @user = User.find( params[:user_id] )
        
        # Create profile linked to this specific user
        @profile = @user.build_profile( profile_params )
        if @profile.save
            flash[:success] = "Profile has been created"
            redirect_to user_path(id: params[:user_id])
        else
            render action: :new
        end    
    end
    
    # GET request view for /users/:user_id/profile/edit
    def edit
        # Retrieving the user and assigning the user profile to @profile
        @profile = User.find(params[:user_id]).profile
    end
    
    # PATCH request for user profile /users/:user_id/profile
    def update
        # Retrieving the user with the current user id
        @user = User.find(params[:user_id])
        # Retrieving that user's profile and assigning to @profile
        @profile = @user.profile
        # Whitelisting and saving the attributes(update only)
        if @profile.update_attributes(profile_params)
           flash[:success] = "Profile Updated!"
        # Sending back the user to user show(user profile view)
           redirect_to user_path(id: params[:user_id])
        else
        # If update fails rendering the edit page  
            render action: :edit
        end   
    end    
    private
        def profile_params
            params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :email, :description)
        end
        
        def current_user_only
           @user = User.find(params[:user_id])
           redirect_to root_url unless @user == current_user
        end    
end