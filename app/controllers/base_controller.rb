class BaseController < ApplicationController
  # before_action :guard_admin

  private

  def guard_admin
    return unless current_user.admin?

    flash[:error] = t "permission_denied"
    redirect_to admin_root_path
  end
end
