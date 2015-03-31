require 'controller_spec_helper'

describe API::V1::APIController, type: :controller do
  describe 'GET #index' do
    controller do
      def index
        render json: :passed
      end
    end

    it 'responds with status ok' do
      get :index, format: :json
      expect(response.status).to eq(200)
    end
  end
end