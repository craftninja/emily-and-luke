class Family < ActiveRecord::Base
  has_many :users, through: :family_memberships
  has_many :family_memberships
end
