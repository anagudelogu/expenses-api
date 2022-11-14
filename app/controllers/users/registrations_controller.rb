# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix
  before_action :configure_sign_up_params
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: { data: UserSerializer.new(resource).serializable_hash[:data][:attributes] }, status: :created
    else
      render json: {
        errors: resource.errors.full_messages.map { |error| { status: '422', title: error } },
      }, status: :unprocessable_entity
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
