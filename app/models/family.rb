class Family < ActiveRecord::Base
  has_many :guests, through: :family_memberships
  has_many :family_memberships

  validates_presence_of :secret_code
end
