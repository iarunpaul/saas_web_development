class Users::RegistrationsController < Devise::RegistrationsController
  def new
    
  end
  
  def create
    super do |resource|
      # if params[:plan]
        # resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save
        else
          
          resource.save
          
        end
      # end
    end
  end
end  