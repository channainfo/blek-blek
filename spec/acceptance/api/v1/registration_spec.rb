require 'api_spec_helper'

api_resource "User Registration" do
  api_post_path "/registrations" do
    parameter :email, 'User email', required: true
    parameter :user_name, 'Login name', required: true
    parameter :password, 'Login password', required: true
    parameter :full_name, 'User full name', required: true

    example "Register an account" do
      do_request(email: 'tola@gmail.com', user_name: 'tola', password: 'sok-tola', full_name: 'Channa Ly')
      
      response_json = as_json(response_body)
      expect(response_json['access_token']).to_not be_nil
      expect(status).to eq 201
    end
  end
end