class Admin::BaseController < ApplicationController
  before_action :check_role
  layout "layouts/application_admin"

  def check_role
    redirect_to(root_path) unless current_user&.admin?
  end
end
