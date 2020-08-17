class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      activate user
    else
      flash[:danger] = t "sessions.new.error_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def activate user
    if user.activated?
      log_in user
      params[:session][:remember_me] ==
          Settings.validations.users.remember_true ? remember(user)
          : forget(user)
      redirect_back_or user
    else
      flash[:warning] = t "mail.inform_confirmation_email"
      redirect_to root_url
    end
  end
end
