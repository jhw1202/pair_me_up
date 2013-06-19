class Member < ActiveRecord::Base
  has_many :memberships
  has_many :teams, :through => :memberships
end
