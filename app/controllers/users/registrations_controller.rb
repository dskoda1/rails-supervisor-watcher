class Users::RegistrationsController < Devise::RegistrationsController
  
  protected

  def after_sign_up_path_for(resource)
    index_path
  end
  
  # See the code of Devise::RegistrationsController at https://github.com/plataformatec/devise/blob/master/app/controllers/devise/registrations_controller.rb
  
end
