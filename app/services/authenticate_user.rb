class AuthenticateUser < ApplicationService
  def initialize(email, password)
    @email = email
    @password = password
  end
  
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by(email: email)
    return user if user&.authenticate(password)
    errors.add :user_authentication, 'invalid credentials'
  end
end