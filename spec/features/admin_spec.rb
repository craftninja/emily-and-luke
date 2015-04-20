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
    expect(current_path).to eq root_path
  end

  scenario 'Admins can manage guests' do
    password = 'password'
    admin = create_user(password)
    visit login_path
    fill_in 'Username', with: admin.username
    fill_in 'Password', with: password
    click_on 'Let me in!'
    expect(page).to_not have_content('RSVP')
    click_on 'Guests'
    click_on 'Add Family'
    click_on 'Add Guests to this Family'
    expect(page).to have_content("Secret code can't be blank")
    fill_in 'Invitation Code', with: 'socks'
    click_on 'Add Guests to this Family'
    expect(page).to have_content('socks')
    click_on 'Add to Family'
    expect(page).to have_content("First name can't be blank Last name can't be blank")
    fill_in 'First Name', with: 'Jared'
    fill_in 'Last Name', with: 'Plootzer'
    click_on 'Add to Family'
    click_on 'Delete this Family Member'
    expect(page).to have_content('Guest List')
    click_on 'Add Family'
    fill_in 'Invitation Code', with: 'socks'
    fill_in 'Address', with: '123 Awesome Street'
    fill_in 'City', with: 'Awesometown'
    fill_in 'State', with: 'Colorado'
    fill_in 'Zip', with: '80302'
    click_on 'Add Guests to this Family'
    expect(page).to have_content('socks')
    expect(page).to have_content('123 Awesome Street')
    expect(page).to have_content('Awesometown')
    expect(page).to have_content('Colorado')
    expect(page).to have_content('80302')
    fill_in 'First Name', with: 'Jared'
    fill_in 'Last Name', with: 'Platzer'
    click_on 'Add to Family'
    click_on 'Guests'
    expect(page).to have_content('Jared Platzer')
    click_on 'See this Family'
    fill_in 'First Name', with: 'Jared Platzer'
    fill_in 'Last Name', with: 'Guest'
    click_on 'Add to Family'
    expect(page).to have_content('Guest')
    click_on "Update this Family's deets"
    fill_in 'Invitation Code', with: 'chacha'
    fill_in 'Address', with: '456 Super Drive'
    fill_in 'City', with: 'Supercity'
    fill_in 'State', with: 'Colorady'
    fill_in 'Zip', with: '80203'
    click_on 'Update this Family'
    expect(page).to have_content('chacha')
    expect(page).to have_content('456 Super Drive')
    expect(page).to have_content('Supercity')
    expect(page).to have_content('Colorady')
    expect(page).to have_content('80203')
    expect(page).to_not have_content('socks')
    expect(page).to_not have_content('123 Awesome Street')
    expect(page).to_not have_content('Awesometown')
    expect(page).to_not have_content('Colorado')
    expect(page).to_not have_content('80302')
  end

  scenario 'Admins can log gift information' do
    guest = create_guest
    family = create_family
    family_membership = create_family_membership(family, guest)
    password = 'password'
    admin = create_user(password)
    login(password, admin)
    visit guests_path
    click_on 'Gifts'
    select guest.full_name, from: :gift_family_id
    fill_in :gift_description, with: 'Awesome thing'
    click_on 'Thank you!'
    within 'table' do
      expect(page).to have_content guest.full_name
      expect(page).to have_content 'Awesome thing'
      expect(page).to have_content 'Thank You Sent?'
      expect(page).to have_css '.glyphicon-remove.text-danger'
    end
  end

  scenario 'Only logged in admins have access to family, guest, gift controllers' do
    visit guests_path

    expect(page).to have_content('Oops! That does not exist')
    expect(current_path).to eq root_path
    expect(page).to_not have_content('Guest List')

    visit new_family_path

    expect(page).to have_content('Oops! That does not exist')
    expect(current_path).to eq root_path
    expect(page).to_not have_content('Guest List')

    visit gifts_path

    expect(page).to have_content('Oops! That does not exist')
    expect(current_path).to eq root_path
    expect(page).to_not have_content('Gift List')
  end


end
