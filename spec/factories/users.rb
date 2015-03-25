FactoryGirl.define do
  factory :user do
    full_name "MyString"
    short_name "MyString"

    password_digest "MyString"
    sequence(:fb_id) {|n| "0982887173017745883#{n}"}
    reset_password_token "MyString"
    reset_password_token_at "2015-03-25 15:15:10"
    title "MyString"
    role User::ROLE_USER
    avatar "MyString"
    gender "MyString"

    last_signed_in_at "2015-03-25 15:15:10"
    sequence(:user_name) {|n| "user_name_#{n}"}
    sequence(:email) {|n| "alert-#{n}@ilabsea.org"}
  end
end
