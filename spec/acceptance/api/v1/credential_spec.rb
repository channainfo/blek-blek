require 'api_spec_helper'

api_resource "Users" do
  api_get_path '/me' do
    example 'Get current user info' do
      do_request
      expect(status).to eq 200
    end
  end
end