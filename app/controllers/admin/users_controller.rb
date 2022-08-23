class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: %i(show destroy)

  def index
    @users = User.all
  end

  def show; end

  def destroy
    if @user.destroy
      flash[:success] = t ".user_delete_success"
    else
      flash[:error] = t ".user_delete_fail"
    end
    redirect_to admin_users_path
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:error] = t "admin.users.not_found"
    redirect_to admin_users_path
  end
end
