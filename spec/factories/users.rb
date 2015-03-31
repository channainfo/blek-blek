FactoryGirl.define do
  factory :user do
    full_name Faker::Name.name

    password_digest "MyString"
    sequence(:fb_id) {|n| "0982887173017745883#{n}"}
    reset_password_token "01029jdjslddjsj"
    reset_password_token_at "2015-03-25 15:15:10"
    role User::ROLE_USER

    avatar {
      avatar_file = File.join(Rails.root, "spec", "static_files", "users", "avatar.png")
      Rack::Test::UploadedFile.new( File.open(avatar_file))
    }

    gender "MyString"

    last_signed_in_at "2015-03-25 15:15:10"
    sequence(:user_name) {|n| "user_name_#{n}"}
    sequence(:email) {|n| "#{n}-#{Faker::Internet.email}"}
  end
end
