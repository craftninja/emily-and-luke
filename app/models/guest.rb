class Guest < ActiveRecord::Base
  has_one :family, through: :family_membership
  has_one :family_membership

  def full_name
    "#{first_name} #{last_name}"
  end

  def family_members
    self.family.guests
  end

end
