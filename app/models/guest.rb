class Guest < ActiveRecord::Base
  has_one :family, through: :family_membership
  has_one :family_membership, dependent: :destroy

  validates_presence_of :first_name, :last_name

  def full_name
    "#{first_name} #{last_name}"
  end

  def family_members
    self.family.guests
  end

  def family_id
    self.family.id
  end

end
