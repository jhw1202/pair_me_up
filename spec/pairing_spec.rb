require 'spec_helper'

describe Pairing do
  let(:pairing) { FactoryGirl.build(:pairing) }

  it "should return ids of paired members" do
    pairing.pair.should eq [pairing.member_1, pairing.member_2]
  end

  it "should reset timestamp time to beginning of day" do
    pairing.save
    pairing.created_at.strftime("%H").should eq "00"
  end
end
