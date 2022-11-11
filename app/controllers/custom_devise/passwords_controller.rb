class CustomDevise::PasswordsController < Devise::PasswordsController

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name, resource_params[:email]))
    else
      respond_with(resource)
    end
  end

  def request_link_sent
    @email = params[:email]
  end

  protected
  def after_sending_reset_password_instructions_path_for(resource_name, email)
    #TODO: This sends the email as a parameter in a GET request so it's visible
    password_request_link_sent_path(email: email) if is_navigational_format?
  end
end