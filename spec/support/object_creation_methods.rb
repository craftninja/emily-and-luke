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

def create_registry(options = {})
  Registry.create!({
    :title => 'Davis Clothing Company',
    :url => 'http://www.davis-clothing-company.com',
    :description => 'Davis Clothing Company is a lovely mercantile that has been open for over 100 years. They have all sorts of top end authentic American West clothing, but really shine in hats. Be sure to visit if you are ever in Delta!\n\nWe would love a gift certificate for these guys for some new fancy duds!'
  }.merge(options))
end
