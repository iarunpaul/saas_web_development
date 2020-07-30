class User < ApplicationRecord

  before_create :confirmation_token
  # after_create :confirmation_email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :plan
  has_one :profile

  attr_accessor :stripe_card_token

  # If Pro user passes the validation for email, password etc. then call Stripe
  # and tell Stripe to add a subscription by charging customer's card
  # Stripe then returns a customer token in response
  # Store the token id as customer id and save the user
  def save_with_subscription
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  end

  private

    def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end

    # def confirmation_email
    #   UserMailer.registration_confirmation(self)
    # end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

end
