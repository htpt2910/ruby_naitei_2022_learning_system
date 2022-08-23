# frozen_string_literal: true

class Admin::ListUsersComponent < ViewComponent::Base
  include Admin::UsersHelper

  def initialize users:
    super
    @users = filter_user users
  end
end
