require 'rails_helper'

feature 'RSVP - ' do
  scenario 'User can enter their name and find their info' do
    u1 = create_user(
      :first_name => 'Amber',
      :last_name => 'Corcoran'
    )
    u2 = create_user(
      :first_name => 'Edward',
      :last_name => 'Corcoran'
    )
    fam = create_family(:secret_code => '1234')
    create_family_membership(fam, u1)
    create_family_membership(fam, u2)

    visit '/'
    click_on 'RSVP'
    fill_in 'First Name', with: 'Amber'
    fill_in 'Last Name', with: 'Corcoran'
    fill_in 'Secret Code', with: '1234'
    click_on 'Find me'
    expect(page).to have_content('Amber Corcoran')
    expect(page).to have_content('Edward Corcoran')
    expect(page).to have_content('You have not submitted an RSVP')
    expect(page).to have_link("Répondez S'il Vous Plaît")
  end

  scenario 'User can RSVP, update address and dietary restrictions' do
    u1 = create_user(
      :first_name => 'Jared',
      :last_name => 'Platzer'
    )
    fam = create_family(:secret_code => '2345')
    create_family_membership(fam, u1)

    visit '/'
    click_on 'RSVP'
    fill_in 'First Name', with: u1.first_name
    fill_in 'Last Name', with: u1.last_name
    fill_in 'Secret Code', with: fam.secret_code
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
    expect(page).to have_content('12345 ')
    expect(page).to_not have_link("Répondez S'il Vous Plaît")
    expect(page).to have_link('Update my RSVP')
    expect(page).to have_content('Dietary Restrictions: none')

    click_on "Update #{u1.first_name}'s dietary restrictions"
    fill_in 'Dietary Restrictions', with: 'No endangered species'
    click_on "That's what I'm eating these days"

    expect(page).to have_content('No endangered species')
  end

  scenario 'User who is not found can submit 3 times before suggesting to contact us' do
    visit '/'
    click_on 'RSVP'
    fill_in 'First Name', with: 'Frank'
    fill_in 'Last Name', with: 'Sinatra'
    fill_in 'Secret Code', with: '1234'
    click_on 'Find me'
    expect(page).to have_content('Oh no! We could not find your record. Try again.')
    fill_in 'First Name', with: 'Frank'
    fill_in 'Last Name', with: 'Sinatra'
    fill_in 'Secret Code', with: '6969'
    click_on 'Find me'
    expect(page).to have_content('Oh no! We could not find your record. Try again.')
    fill_in 'First Name', with: 'Frank'
    fill_in 'Last Name', with: 'Sinatra'
    fill_in 'Secret Code', with: '9876'
    click_on 'Find me'
    expect(page).to have_content('Still could not find you. Contact us and we can sort it out!')
  end
end
