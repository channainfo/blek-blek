FactoryGirl.define do
  factory :oauth_client, :class => Doorkeeper::Application do
    sequence(:name){ |n| "Application #{n}" }
    redirect_uri "urn:ietf:wg:oauth:2.0:oob"
  end
end
