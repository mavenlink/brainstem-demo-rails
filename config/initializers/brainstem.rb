Rails.application.config.to_prepare do
  # Forget all Brainstem configuration.
  Brainstem.reset!

  # Set the current default API namespace.
  Brainstem.default_namespace = :v1

  # (Optional) Load a default base helper into all presenters. You could use this to bring in a concept like `current_user`.
  # While not necessarily the best approach, something like http://stackoverflow.com/a/11670283 can currently be used to
  # access the requesting user inside of a Brainstem presenter. We hope to clean this up by allowing a user to be passed in
  # when presenting in the future.
  module Api
    module V1
      module Helper
        def current_user
          # However you get your current user.  In devise this would be... warden.user ?
        end
      end
    end
  end
  Brainstem::Presenter.helper(Api::V1::Helper)

  # Load the presenters themselves.
  require_dependency 'api/v1/widget_presenter'
  require_dependency 'api/v1/feature_presenter'
  require_dependency 'api/v1/location_presenter'

  # Or you could do something like this:
  #  Dir[Rails.root.join("lib/api/v1/*_presenter.rb").to_s].each { |p| require_dependency p }
end
