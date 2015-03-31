require 'controller_spec_helper'

describe API::V1::CredentialsController, type: :controller do
  describe "GET #{ENV['API_PATH']}/me" do
    it 'responds with status OK' do
      get :me, format: :json
      expect(response.status).to eq 200
    end
  end
end