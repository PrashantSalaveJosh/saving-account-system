# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resourse, options = {})
    render json: {
      code: 200,
      message: I18n.t('user.login.success'),
      data: current_user
    }, status: :ok
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers["Authorization"].split(" ")[1],
                             Rails.application.credentials.fetch(:secret_key_base)).first
    current_user = User.find_by(jti: jwt_payload["jti"])
    if current_user
      render json: {
        status: 200,
        message: I18n.t('user.logout.success'),
      }, status: :ok
    else
      render json: {
        status: 401,
        message: I18n.t('user.logout.failure'),
      }, status: :unauthorized
    end
  end
end
