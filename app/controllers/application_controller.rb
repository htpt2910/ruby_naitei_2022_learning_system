class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers
  include Pagy::Backend
  include CanCan::ControllerAdditions
  before_action :switch_locale, :authenticate_user!
  layout :choose_layout

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def choose_layout
    if current_user.nil?
      "devise"
    elsif current_user.admin?
      "application_admin"
    else
      "application"
    end
  end

  private

  def switch_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
