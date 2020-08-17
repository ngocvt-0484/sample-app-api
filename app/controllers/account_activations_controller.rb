class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email] if params[:email]

    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_activation
      log_in user
      flash[:success] = t "inform_success"
      redirect_to user
    else
      flash[:danger] = t "inform_error"
      redirect_to root_url
    end
  end
end
