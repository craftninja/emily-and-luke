def create_user(options = {})
  User.create!({
    :first_name => 'Amber',
    :last_name => 'Corcoran',
    :email => 'amber@example.com'
  }.merge(options))
end

def create_family(options = {})
  Family.create!({
  }.merge(options))
end

def create_family_membership(family, user)
  FamilyMembership.create!(
    :family => family,
    :user => user
  )
end
