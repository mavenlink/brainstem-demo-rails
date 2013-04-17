Brainstem.default_namespace = :v1

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

require 'api/v1/widget_presenter'
require 'api/v1/feature_presenter'
require 'api/v1/location_presenter'

# Or you could do something like this:
#  Dir[Rails.root.join("lib/api/v1/*_presenter.rb").to_s].each { |p| require p }
