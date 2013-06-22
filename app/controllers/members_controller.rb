class MembersController < ApplicationController
  def new
    @member = Member.new
    @team = Team.find(params[:team_id])
  end

  def create
    member = Member.new(params[:member])

    if member.save
      Team.find(params[:team_id]).members << member
      redirect_to root_path
    end
  end

  def destroy
    Member.find(params[:id]).destroy
    redirect_to root_path
  end

end
