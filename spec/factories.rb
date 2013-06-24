FactoryGirl.define do

  factory :member do
    sequence(:name) {|n| "#{n} John Doe" }
    sequence(:email) {|n| "#{n}test@email.com"}
  end

  factory :team do
    sequence(:name) {|n| "Team #{n}"}
  end

  factory :pairing do
    sequence(:member_1) {|n| n}
    sequence(:member_2) {|n| n + 1}
    sequence(:team_id) {|n| n + 10 }
  end

end
