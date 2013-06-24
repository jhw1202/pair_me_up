require 'spec_helper'

describe "root page" do
  # before(:all) do
  #   load "#{Rails.root}/db/seeds.rb"
  # end

  before(:each) do
    visit root_path
  end

  it "should display page logo" do
    page.should have_content("Pair Me Up")
  end

  it "should display how it works link" do
    page.should have_content("How it works")
  end

  it "should have clickable how it works that expands to show description" do
    click_link "How it works"
    page.should have_content("5pm")
  end

  it "should have link to show members" do
    page.should have_content("Show members")
  end

  it "should have show members link for each team" do
    page.all('a.members-list-expand').length.should eq page.all('h5').length
  end


end
