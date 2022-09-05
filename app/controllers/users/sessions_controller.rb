# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for resource
    if resource.admin?
      admin_root_path
    else
      root_path
    end
  end

  def after_sign_out_path_for _resource
    new_user_session_path
  end
end