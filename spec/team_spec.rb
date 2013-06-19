require 'spec_helper'

describe Team do

  let(:team) {FactoryGirl.create(:team)}
  let(:member) {FactoryGirl.create(:member)}


  it "should respond to members" do
    team.members.should eq []
  end

  it "should belong to a team" do
    team.members << member
    team.members.should include(member)
  end

  it "should validate team name uniqueness" do
    invalid_team = Team.new(name: team.name)
    invalid_team.save.should eq false
  end
end
