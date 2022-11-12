# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: { data: UserSerializer.new(resource).serializable_hash[:data][:attributes] }, status: :created
    else
      render json: {
        status: '422',
        errors: resource.errors.full_messages,
      }, status: :unprocessable_entity
    end
  end
end
