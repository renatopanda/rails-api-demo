#app/commands/authenticate_user.rb
class AuthenticateUser
  prepend SimpleCommand

  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
  	@result = nil
    if password_valid?
      @result = JwtService.encode(contents)
    else
      errors.add(:authenticate, 'error authenticating user')
    end
  end

  def user
    @user ||= User.find_by(email: email)
  end

  def password_valid?
    user && user.authenticate(password)
  end

  def contents
    {
      user_id: user.id,
      exp: 24.hours.from_now.to_i
    }
  end
end

