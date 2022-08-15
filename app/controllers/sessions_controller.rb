class SessionsController < ApplicationController
  layout "signin", only: %i(new create)
  # before_action :check_role, only: :handle_signin

  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      handle_signin user
    else
      flash[:error] = t ".signin_fail"
      redirect_to signin_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to signin_path
  end

  def handle_signin user
    sign_in user
    # check_role
    flash[:success] = t ".signin_success", user_name: user.name
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_to root_path
  end

  def find_user
    user = User.find_by email: params[:session][:email].downcase
    return if user

    flash[:error] = t ".email_not_found"
    redirect_to signin_path
  end
end
