class FamilyMembership < ActiveRecord::Base
  belongs_to :family
  belongs_to :user

  validates_presence_of :family_id, :user_id
end
