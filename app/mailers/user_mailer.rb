class UserMailer < ActionMailer::Base
    default :from => "monaey@gmail.com"

     def registration_confirmation(user)
        @email = user.email
        @user = user
        puts @user
        mail(:to => user.email, :subject => "Registration Confirmation")
     end
 end 