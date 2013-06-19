class Team < ActiveRecord::Base
  has_many :memberships
  has_many :members, :through => :memberships

  validates :name, :uniqueness => true

  attr_accessible :name
end
