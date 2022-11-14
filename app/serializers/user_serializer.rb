class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email

  attribute :created_date do |user|
    user&.created_at&.strftime('%d/%m/%Y')
  end
end
