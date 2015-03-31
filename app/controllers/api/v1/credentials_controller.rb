module API::V1
  class CredentialsController < APIController
    # before_action :doorkeeper_authorize!
    # respond_to :json
    # GET /me.json
    def me
      render json: current_resource_owner, serializer: UserSerializer
    end
  end
end