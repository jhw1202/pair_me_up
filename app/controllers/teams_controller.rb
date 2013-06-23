class TeamsController < ApplicationController
  def index
    @teams = Team.includes(:members)
  end

  def new
    @team = Team.new
  end

  def create
    Team.create(params[:team])
    flash[:notice] = "Successfully created a new team"
    redirect_to root_path
  end

  def destroy
    team = Team.find(params[:id]).destroy
    flash[:notice] = "Team deleted. If a member belongs to multiple teams, only their membership to this deleted team is destroyed."
    redirect_to root_path
  end
end
