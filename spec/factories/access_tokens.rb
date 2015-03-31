FactoryGirl.define do
  factory :access_token, :class => Doorkeeper::AccessToken do
    sequence(:resource_owner_id) { |n| n }
    association :application, factory: :oauth_client

    factory :clientless_access_token do
      application nil
    end
  end
end
