class Team < ActiveRecord::Base
  has_many :memberships
  has_many :members, :through => :memberships

  validates :name, :uniqueness => true

  attr_accessible :name

  # before_save :pick_pairs

  def pick_pairs
    this_week = []
    team_pairs = remove_previous_week_pairs(self.all_possible_pairs)

    until this_week.length == (members.length / 2) do
      pair = team_pairs.sample
      team_pairs = remove_overlap(team_pairs, pair)
      this_week << pair
    end

    create_pairs_log(this_week)

    p this_week

  end

  def all_possible_pairs
    members = self.members
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

  ########################################################
  ## CHANGE THIS METHOD SO IT USES FOR LAST WEEKS DATA ##
  ########################################################

  def remove_previous_week_pairs(team_pairs)
    last_week = Pairing.find(:all, :order => "id DESC", :limit => 2)
    team_pairs - last_week.map(&:pair)
  end

  ########################################################
  ########################################################


  def create_pairs_log(pairs)
    pairs.each do |pair|
      Pairing.create(member_1: pair[0], member_2: pair[1])
    end
  end

end
