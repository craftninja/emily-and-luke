require 'rails_helper'

feature 'Admin - ' do

  scenario 'Admins can log in via /login, log out' do
    password = 'password'
    admin = create_user(password)
    visit login_path
    click_on 'Let me in!'
    expect(page).to have_content('Could not log you in. Contact us and we can sort it out!')

    fill_in 'Username', with: admin.username
    fill_in 'Password', with: password
    click_on 'Let me in!'
    within '.nav' do
      click_on 'Log out'
    end
    expect(page).to_not have_content('Log out')
    within '.jumbotron' do
      expect(page).to have_content('Emily and Luke May 16th, 2015 in Lyons, Colorado')
    end
  end

end
