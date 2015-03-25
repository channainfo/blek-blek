# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_attrs = [
  {user_name: 'admin', email: 'admin@blek.com', full_name: 'Admin System', password: '123456', role: User::ROLE_ADMIN},
  {user_name: 'user', email: 'user@blek.com', full_name: 'User System', password: '123456', role: User::ROLE_USER}
]

user_attrs.each do |user_attr|
  user = User.where(email: user_attr[:email]).first_or_initialize
  user.update_attributes(user_attr)
  user.save!
end
