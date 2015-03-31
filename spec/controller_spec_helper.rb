require 'rails_helper'

RSpec.configure do |c|
  c.before(:each, type: :controller) do
    allow(controller).to receive(:doorkeeper_token) { double(acceptable?: true) }
    allow(controller).to receive(:current_resource_owner) { create(:user) }
  end
end