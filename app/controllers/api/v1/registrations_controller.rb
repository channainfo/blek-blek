module API::V1
  class RegistrationsController < APIController
    before_action only: [:create] do
      doorkeeper_authorize! :write
    end

    # TODO should only use with scope scope: [:write]
    def create
      user = User.new(filter_params)
      user.save!

      access_token = Doorkeeper::AccessToken.create!(
        application_id:    doorkeeper_token.application_id,
        resource_owner_id: user.id,
        expires_in:        Doorkeeper.configuration.access_token_expires_in
      )

      meta = { access_token: access_token.token,
               token_type:   'bearer',
               expires_in:   access_token.expires_in }

      render json: user, meta: meta, meta_key: 'authorization', status: created
    end

    private
    def filter_params
      params.permit(:full_name, :email, :password, :user_name, :fb_id)
    end
  end
end