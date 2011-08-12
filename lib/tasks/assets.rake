namespace :assets do
  task :ensure_env do
    ENV["RAILS_GROUPS"] ||= "assets"
    ENV["RAILS_ENV"]    ||= "production"
  end

  desc "Compile all the assets named in config.assets.precompile"
  task :precompile_for_production => :ensure_env do
    Rake::Task["environment"].invoke
    Sprockets::Helpers::RailsHelper

    Rails.application.assets.version = ENV["RAILS_ENV"] + "#{'-' + Rails.application.config.assets.version if Rails.application.config.assets.version.present?}"

    assets = Rails.application.config.assets.precompile
    # Always perform caching so that asset_path appends the timestamps to file references.
    Rails.application.config.action_controller.perform_caching = true
    Rails.application.assets.precompile(*assets)
  end
end
