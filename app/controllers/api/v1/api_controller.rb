module API::V1
  class APIController < ActionController::Base
    # API only available for OAuth users
    # require access token in all actions
    before_action :doorkeeper_authorize!

    # Current resource owner
    def current_resource_owner
      @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    # Custom unauthorized message
    def doorkeeper_unauthorized_render_options
      {:json => {:error => "Not authorized"}}
    end

    def default_serializer_options
      { root: false }
    end

  end
end