class UsersController < ApplicationController
  before_action :find_user, only: %i(show destroy)

  def index
    @users = User.all.learners
  end

  def show; end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
    else
      flash[:error] = t ".fail"
    end

    redirect_to users_path
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:error] = t "admin.users.not_found"
    redirect_to users_path
  end
end
