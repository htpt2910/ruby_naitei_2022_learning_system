module Admin::UsersHelper
  def filter_user users
    users.reject(&:admin)
  end
end
