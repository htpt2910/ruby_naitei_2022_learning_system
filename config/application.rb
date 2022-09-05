require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RubyNaitei2022LearningSystem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.i18n.load_path += Dir[Rails.root.join("path/to")]
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :en
    config.time_zone = "Hanoi"
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**",
                                                 "*.{rb,yml}").to_s]
    config.view_component.preview_paths << "#{Rails.root}/spec/components/previews"
    config.action_dispatch.rescue_responses.merge!('CanCan::AccessDenied' => :unauthorized)
  end
end
