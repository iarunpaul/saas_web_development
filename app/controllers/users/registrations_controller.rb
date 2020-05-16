class Users::RegistrationsController < Devise::RegistrationsController
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
      end
    end
  end
end