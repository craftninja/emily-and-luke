require 'rails_helper'

feature 'RSVP - ' do
  scenario 'User can enter their name and find their info' do
    g1 = create_guest(
      :first_name => 'Amber',
      :last_name => 'Corcoran'
    )
    g2 = create_guest(
      :first_name => 'Edward',
      :last_name => 'Corcoran'
    )
    fam = create_family(:secret_code => '1234')
    create_family_membership(fam, g1)
    create_family_membership(fam, g2)

    visit '/'
    click_on 'RSVP'
    fill_in 'First Name', with: 'Amber'
    fill_in 'Last Name', with: 'Corcoran'
    fill_in 'Invitation Code', with: '1234'
    click_on 'Find me'
    expect(page).to have_content('Amber Corcoran')
    expect(page).to have_content('Edward Corcoran')
    expect(page).to have_content('You have not submitted an RSVP')
    expect(page).to have_link("Répondez S'il Vous Plaît")
  end

  scenario 'User can RSVP, update address and dietary restrictions' do
    g1 = create_guest(
      :first_name => 'Jared',
      :last_name => 'Platzer'
    )
    fam = create_family(:secret_code => '2345')
    create_family_membership(fam, g1)

    visit '/'
    click_on 'RSVP'
    fill_in 'First Name', with: g1.first_name
    fill_in 'Last Name', with: g1.last_name
    fill_in 'Invitation Code', with: fam.secret_code
    click_on 'Find me'
    click_on "Répondez S'il Vous Plaît"
    fill_in 'Address', with: '1234 Sesame Street'
    fill_in 'City', with: 'Awesometown'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '12345'
    choose 'will be attending'
    click_on "Répondez S'il Vous Plaît"

    expect(page).to have_content('You have submitted an RSVP for 1')
    expect(page).to have_content('1234 Sesame Street')
    expect(page).to have_content('Awesometown')
    expect(page).to have_content('CO')
    expect(page).to have_content('12345')
    expect(page).to_not have_link("Répondez S'il Vous Plaît")
    expect(page).to have_link('Update my RSVP')
    expect(page).to have_content('Dietary Restrictions: none')

    click_on "Update #{g1.first_name}'s dietary restrictions"
    fill_in 'Dietary Restrictions', with: 'No endangered species'
    click_on "That's what I'm eating these days"

    expect(page).to have_content('No endangered species')
  end

  scenario 'User who is not found can submit 3 times before suggesting to contact us' do
    visit '/'
    click_on 'RSVP'
    fill_in 'First Name', with: 'Frank'
    fill_in 'Last Name', with: 'Sinatra'
    fill_in 'Invitation Code', with: '1234'
    click_on 'Find me'
    expect(page).to have_content('Oh no! We could not find your record. Try again.')
    fill_in 'First Name', with: 'Frank'
    fill_in 'Last Name', with: 'Sinatra'
    fill_in 'Invitation Code', with: '6969'
    click_on 'Find me'
    expect(page).to have_content('Oh no! We could not find your record. Try again.')
    fill_in 'First Name', with: 'Frank'
    fill_in 'Last Name', with: 'Sinatra'
    fill_in 'Invitation Code', with: '9876'
    click_on 'Find me'
    expect(page).to have_content('Still could not find you. Contact us and we can sort it out!')
  end

  scenario 'User cannot only get to RSVP index if they do not enter a valid secret code' do
    g1 = create_guest(
      :first_name => 'Jared',
      :last_name => 'Platzer'
    )
    fam = create_family(:secret_code => '2345')
    create_family_membership(fam, g1)

    visit rsvp_path(g1.id)
    expect(page).to have_content('We really hope you can make it!')
    expect(page).to_not have_content(g1.full_name)

    visit edit_rsvp_path(g1.id)
    expect(page).to have_content('We really hope you can make it!')
    expect(page).to_not have_content(g1.full_name)

    visit rsvp_dietary_restrictions_path(g1.id)
    expect(page).to have_content('We really hope you can make it!')
    expect(page).to_not have_content(g1.full_name)
  end

  scenario 'When user exits RSVP section, user can only get to RSVP action index' do
    g1 = create_guest(
      :first_name => 'Jared',
      :last_name => 'Platzer'
    )
    fam = create_family(:secret_code => '2345')
    create_family_membership(fam, g1)

    visit '/'
    click_on 'RSVP'
    fill_in 'First Name', with: g1.first_name
    fill_in 'Last Name', with: g1.last_name
    fill_in 'Invitation Code', with: fam.secret_code
    click_on 'Find me'
    visit '/'
    visit rsvp_path(g1.id)

    expect(page).to have_content('We really hope you can make it!')
    expect(page).to_not have_content(g1.full_name)
  end
end
