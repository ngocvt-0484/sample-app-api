class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mail.head")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("password_resets.new.title_reset_passoword")
  end
end
