require 'spec_helper'

describe Member do

  let(:member) {FactoryGirl.build(:member)}
  let(:team) {FactoryGirl.build(:team)}


  it "should respond to teams" do
    member.teams.should eq []
  end

  it "should be able to have membership in a team" do
    member.teams << team
    member.teams.should include(team)
  end

  it "should validate uniqueness of email" do
    invalid_member = Member.new(name: "Johnny Bravo", email: member.email)
    member.save
    invalid_member.save.should eq false
  end

  it "should validate format of email" do
    invalid_member = Member.new(name: "Nicolas Cage", email: "iamcage")
    invalid_member.save.should eq false
  end
end
