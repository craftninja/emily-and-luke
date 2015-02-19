class FamilyMembership < ActiveRecord::Base
  belongs_to :family
  belongs_to :guest

  validates_presence_of :family_id, :guest_id
end
