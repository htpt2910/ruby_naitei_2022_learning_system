class BaseController < ApplicationController
  before_action :check_role

  def check_role
    redirect_to(admin_root_path) if current_user&.admin?
  end
end
