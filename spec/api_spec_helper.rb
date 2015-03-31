require 'rails_helper'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |c|
  c.format = :json
end

RSpec.configure do |c|
  # c.extend APIResourceHelper, type: :api_resource

  c.before(:each, type: :api_resource) do
    header "Host", ENV['API_HOST']
    header "Accept", "application/json"
    header "Authorization", header_token
  end
end


def api_resource description, options={}, &block
  resource description, options.merge(type: :api_resource), &block
end

def api_get_path url, options={}, &block
  build_authentition
  get "#{ENV['API_PATH']}#{url}", options, &block
end


def build_authentition
  let(:oauth_client) { create(:oauth_client) }
  let(:resource_owner) { create(:user) }
  let(:access_token) { create(:access_token, application: oauth_client, resource_owner_id: resource_owner.id) }
  let(:header_token) { "Bearer #{access_token.token}" }
end

