class Member < ActiveRecord::Base
  has_many :memberships
  has_many :teams, :through => :memberships

  validates :email, :uniqueness => true

  attr_accessible :name, :email
end
