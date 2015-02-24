def login(password = 'password', user = create_user)
  visit login_path
  fill_in 'Username', with: user.username
  fill_in 'Password', with: password
  click_on 'Let me in!'
end
