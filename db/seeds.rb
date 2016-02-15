# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(:email => "member@example.com", :role => "admin", :password => "helloworld", :password_confirmation => "helloworld", :username => "blocmentor")
User.create!(:email => "mgolden91@gmail.com", :role => "premium", :password => "helloworld", :password_confirmation => "helloworld", :username => "mattyg" )
User.create!(:email => "testing@testing.com", :role => "standard", :password => "helloworld", :password_confirmation => "helloworld", :username => "testing")
5.times do
  Wiki.create!(
    :title => Faker::Lorem.sentence,
    :user_id => "1",
    :body => Faker::Lorem.paragraph
    )
end
