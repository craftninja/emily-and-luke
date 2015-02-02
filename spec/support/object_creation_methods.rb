def create_user(options = {})
  User.create!({
    :first_name => 'Amber',
    :last_name => 'Corcoran',
    :email => 'amber@example.com'
  }.merge(options))
end
