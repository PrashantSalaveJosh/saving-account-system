# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  before_action :configure_permitted_parameters

  private

  def respond_with(resource, options = {})
    if resource.persisted?
      render json: {
        code: 200,
        message: "Signed up successfully",
        data: resource
      }, status: :ok
    else
      render json: {
        message: "User could not be created successfully",
        errors: resource.errors.full_messages,
      }, status: :unprocessable_entity
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role_id])
  end
end
