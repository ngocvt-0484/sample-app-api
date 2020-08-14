class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.validations.users.email_regex
  USERS_PARAMS_PERMIT = %i(name email password password_confirmation).freeze

  attr_accessor :remember_token

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

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update remember_digest: nil
  end

  private

  def email_downcase
    email.downcase!
  end
end