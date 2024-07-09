class AuthorizeApiRequest < ApplicationService
  attr_reader :headers

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  def user
    # TODO: Instead of looking up the user in the database, we can go to Redis instead
    # to speed up response time and minimize the requests hitting the database.
    # The key can be the decoded_auth_token and the value can be the user object.
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, 'invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add(:token, 'missing token')
      nil
    end
  end
end