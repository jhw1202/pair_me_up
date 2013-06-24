class Member < ActiveRecord::Base
  has_many :memberships
  has_many :teams, :through => :memberships

  validates :email, :uniqueness => true
  validates :email, :format => {:with => /@/ }

  attr_accessible :name, :email
end
