require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'validations' do

    it { should validate_presence_of(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
    it { should validate_presence_of(:email) }
    it { should have_secure_password }

  end

  describe User, '.authenticate' do
    it "authenticates user's email and password" do
      user = create(:user, email: 'user@example.com', password: 'secret123')

      result = User.authenticate('User@example.com', 'secret123')

      expect(result).to eq(user)
    end

    it 'return false if there is no matchs' do
      create(:user, email: 'user@example.com')

      result = User.authenticate('no_user@example.com', 'secret123')

      expect(result).to eq(false)
    end
  end

end
