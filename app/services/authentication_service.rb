class AuthenticationService
  def self.call(email:, password:)
    return nil if email.blank? || password.blank?

    user = User.find_by(email: email.downcase)
    user&.authenticate(password) ? user : nil
  end
end
