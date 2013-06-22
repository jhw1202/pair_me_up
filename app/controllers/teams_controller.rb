class TeamsController < ApplicationController
  def index
    @teams = Team.includes(:members)
  end

  def new
    @team = Team.new
  end

  def create

  end

  def destroy

  end
end
