$blacklist = []

class Team < ActiveRecord::Base
  has_many :memberships
  has_many :members, :through => :memberships

  validates :name, :uniqueness => true

  attr_accessible :name

  # before_save :pick_pairs

  def members_without_blacklist
    members = self.members.includes(:teams)
    filtered = []
    members.each do |member|
      unless $blacklist.include?(member.id)
        filtered << member
      end
    end
    filtered
  end

  def pick_pairs
    members = self.members_without_blacklist

    multiple_team_members = members.select{|m| m.teams.length > 1}.map(&:id)

    this_week = []

    team_pairs = remove_previous_week_pairs(self.all_possible_pairs(members), self.id)

    until this_week.length == (members.length / 2) do
      pair = team_pairs.sample
      team_pairs = remove_overlap(team_pairs, pair)
      this_week << pair
    end

    self.create_pairs_log(this_week)

    blacklist_duplicates(this_week, $blacklist, multiple_team_members)

    p this_week

  end

  def all_possible_pairs(members)
    members = members
    team_pairs = []

    members.each_with_index do |person, index|
      ((index+1)..(members.length-1)).each do |pair_index|
        team_pairs << [person.id, members[pair_index].id]
      end
    end
    team_pairs
  end

  def remove_overlap(team_pairs, current_pair)
    updated_pairs = []
    team_pairs.each do |pair|
      if (pair - current_pair).length == 2
        updated_pairs << pair
      end
    end
    updated_pairs
  end

  def remove_previous_week_pairs(team_pairs, team_id)
    last_week = Pairing.where("team_id = ? AND created_at = ?",
                               team_id, (DateTime.now - 1.week).beginning_of_day)
    team_pairs - last_week.map(&:pair)
  end

  def create_pairs_log(pairs)
    pairs.each do |pair|
      Pairing.create(member_1: pair[0], member_2: pair[1], team_id: self.id)
    end
  end

  def blacklist_duplicates(selected_pairs, blacklist, multiple_team_members)
    selected_pairs.each do |pair|
      if multiple_team_members.include? pair[0]
        blacklist << pair[0]
      elsif multiple_team_members.include? pair[1]
        blacklist << pair[1]
      end
    end
  end

end
