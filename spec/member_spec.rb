require 'spec_helper'

describe Member do

  let(:member) {FactoryGirl.create(:member)}
  let(:team) {FactoryGirl.create(:team)}


  it "should respond to teams" do
    member.teams.should eq []
  end

  it "should be able to have membership in a team" do
    member.teams << team
    member.teams.should include(team)
  end

end
