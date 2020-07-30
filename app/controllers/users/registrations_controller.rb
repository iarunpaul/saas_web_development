class Users::RegistrationsController < Devise::RegistrationsController
  before_action :select_plan, only: :new
  # Extend the default Devise gem behaviour so that
  # the users signing up with a Pro account(plan_id 2) should be
  # saved with a Stripe subscription function
  # Otherwise, save the sign up as usual.
  def create
    super do |resource|

      if params[:plan]
        resource.plan_id = params[:plan]

        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save

        end
        yield resource if block_given?
        if resource.persisted?

          # We know that the user has been persisted to the database, so now we can create our empty profile
          UserMailer.registration_confirmation(resource).deliver

        #   if resource.active_for_authentication?
        #     set_flash_message! :notice, :signed_up
        #     sign_up(resource_name, resource)
        #     respond_with resource, location: after_sign_up_path_for(resource)
        #   else
        #     set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        #     expire_data_after_sign_in!
        #     respond_with resource, location: after_inactive_sign_up_path_for(resource)
        #   end
        # else
        #   clean_up_passwords resource
        #   set_minimum_password_length
        #   respond_with resource
        end
      else
      flash[:error] = "Ooooppss, something went wrong!"
      redirect_to :back

      end
    end
  end

  private
    def select_plan
      unless (params[:plan] == '1' || params[:plan] == '2')
        flash[:notice] = "Please select a membership plan to sign up."
        redirect_to root_url
      end
    end
end