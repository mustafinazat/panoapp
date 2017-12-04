class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

 rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  private

  def user_not_authorized
    flash[:alert] = "Нет прав доступа"
    redirect_to(root_path)
  end



  before_action :configure_devise_permitted_parameters, if: :devise_controller?


   protected

  def configure_devise_permitted_parameters
    registration_params = [:nickname,:avatar, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.permit(:account_update) do 
        |u| u.permit(registration_params << :current_password)
      end
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.permit(:sign_up) do 
        |u| u.permit(registration_params) 
      end
    end
  end



end
