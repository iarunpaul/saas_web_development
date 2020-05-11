class ContactsController < ApplicationController
    # GET request for /contact-us
    # Show new contact form
    def new
        @contact = Contact.new
    end
    
    #POST request /contacts
    def create
        #Mass assignment of form fields to Contact object
        @contact = Contact.new(contact_params)
        
        #Save the Contact object to database
        if @contact.save
            
            #Store form fiels via parameters to variables
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:body]
            
            #Plug variables into Contact Mailer email method 
            # and send email
            ContactMailer.contact_email(name, email, body).deliver
            
            #Store success messsage to flash hash 
            # And redirect to new contact form
            flash[:success] = "Message Sent."
            redirect_to new_contact_path
        else
            # If contact isnt saved save error message in flash hash 
            # and redirect to new form view
            flash[:danger] = @contact.errors.full_messages.join(', ')
            redirect_to new_contact_path
        end
    end    
    private
        
        # To collect data from form we need strong parameters 
        # and whitelist the form fields
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end    
        
end