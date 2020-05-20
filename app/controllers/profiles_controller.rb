class ProfilesController < ApplicationController
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
            redirect_to user_path(params[:user_id])
        else
            render action: :new
        end    
    end
    
    # GET request view for /users/:user_id/profile/edit
    def edit
        
        @profile = User.find(params[:user_id]).profile
    end
    private
        def profile_params
            params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :email, :description)
        end    
end