require 'spec_helper'

describe Team do

  let(:team) {FactoryGirl.build(:team)}
  let(:member) {FactoryGirl.build(:member)}

  context "model" do

    it "should respond to members" do
      team.members.should eq []
    end

    it "member should belong to a team" do
      team.members << member
      team.members.should include(member)
    end

    it "should validate team name uniqueness" do
      invalid_team = Team.new(name: team.name)
      team.save
      invalid_team.save.should eq false
    end

  end

  describe "picking pairs" do
    team_1 = Team.create(name: "Team 1")
    team_2 = Team.create(name: "Team 2")

    %w(Elizabeth Sophia Ludwig Vinny Stacey).each do |member|
      team_1.members << Member.create(name: member, email: Faker::Internet.email)
    end
    %w(Angela Casey William).each do |member|
      team_2.members << Member.create(name: member, email: Faker::Internet.email)
    end
    team_2.members << Member.find_by_name("Ludwig")

    team_1 = Team.includes(:members).find_by_name("Team 1")
    team_2 = Team.includes(:members).find_by_name("Team 2")

    context "filtering pairs" do

      it "should remove previous week's pairs from this week's possible pairs" do
        pair = Pairing.create(member_1: team_1.members.first, member_2: team_1.members.last)
        pair.update_attribute(:created_at, DateTime.now - 1.week)

        all_pairs = team_1.all_possible_pairs(team_1.members)

        team_1.remove_previous_week_pairs(all_pairs, team_1.id)
              .should eq (all_pairs - [[Pairing.last.pair]])
      end

      it "should blacklist member belonging to multiple teams if they're picked as a pair" do
        blacklist = []
        need_blacklist_member = Member.find_by_name("Ludwig")
        pair = (team_1.members - [need_blacklist_member]).sample

        team_1.blacklist_duplicates([[need_blacklist_member.id, pair.id]],
                                     blacklist, [need_blacklist_member.id])
        .should eq [need_blacklist_member.id]
      end

      it "should remove blacklisted member from previous team's pairing" do
        duplicated_member = Member.find_by_name("Ludwig")
        $blacklist = [duplicated_member.id]
        team_1.members_without_blacklist.should eq (team_1.members - [duplicated_member])
      end

    context "generating pairs"

      it "should generate list of all possible pairs for given team" do
        a = Member.find_by_name("Angela").id
        b = Member.find_by_name("Casey").id
        c = Member.find_by_name("William").id
        d = Member.find_by_name("Ludwig").id
        p team_2.members
        all_pairs = [[a,b],[a,c],[a,d],[b,c],[b,d],[c,d]]
        team_2.all_possible_pairs(team_2.members).should eq all_pairs
      end

    end

  end

end


