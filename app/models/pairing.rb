class Pairing < ActiveRecord::Base

  after_create :change_timestamp

  attr_accessible :member_1, :member_2, :team_id

  def change_timestamp
    self.update_attribute(:created_at, DateTime.now.beginning_of_day)
  end

  def pair
    [self.member_1, self.member_2]
  end

end
