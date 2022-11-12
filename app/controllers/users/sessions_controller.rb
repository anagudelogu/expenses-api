# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        data: 'logged out successfully',
      }, status: :ok
    else
      render json: {
        status: '401',
        errors: ["Couldn't find an active session."],
      }, status: :unauthorized
    end
  end
end
