# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Team.create(name: "Team 1")
Team.create(name: "Team 2")

%w(Elizabeth Sophia Ludwig Vinny Stacey).each do |member|
  Team.find_by_name("Team 1").members << Member.create(name: member,
                                                       email: Faker::Internet.email)
end

%w(Angela Casey William).each do |member|
  Team.find_by_name("Team 2").members << Member.create(name: member,
                                                       email: Faker::Internet.email)
end

Team.find_by_name("Team 2").members << Member.find_by_name("Ludwig")
