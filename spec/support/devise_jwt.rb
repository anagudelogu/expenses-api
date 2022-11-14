require 'devise/jwt/test_helpers'

def get_jwt_for(user)
  Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization']
end

def generate_authorization_header_for(user)
  Devise::JWT::TestHelpers.auth_headers({}, user)
end
