class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.validations.users.email_regex
  USERS_PARAMS_PERMIT = %i(name email password password_confirmation).freeze

  validates :name, presence: true,
            length: {maximum: Settings.validations.users.name_max_length}
  validates :email, presence: true,
            length: {maximum: Settings.validations.users.email_max_length},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: true}
  validates :password, presence: true,
            length: {minimum: Settings.validations.users.password_min_length},
            allow_nil: true

  has_secure_password

  before_save :email_downcase

  private

  def email_downcase
    email.downcase!
  end
end
