class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :email, :admin, :created_at_format

  attribute :created_at_format do |object|
    object.created_at.strftime("%m/%d/%Y")
  end
end
