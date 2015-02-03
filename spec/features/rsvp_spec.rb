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
    fam = create_family
    create_family_membership(fam, u1)
    create_family_membership(fam, u2)

    visit '/'
    click_on 'RSVP'
    fill_in 'First Name', with: 'Amber'
    fill_in 'Last Name', with: 'Corcoran'
    click_on 'Find me'
    expect(page).to have_content('Amber Corcoran')
    expect(page).to have_content('Edward Corcoran')
    expect(page).to have_content('You have not submitted an RSVP')
    expect(page).to have_link("Répondez S'il Vous Plaît")
  end

  scenario 'User can RSVP' do
    u1 = create_user(
      :first_name => 'Jared',
      :last_name => 'Platzer'
    )
    u2 = create_user(
      :first_name => 'Jared Platzer',
      :last_name => '+1'
    )
    fam = create_family
    create_family_membership(fam, u1)
    create_family_membership(fam, u2)

    visit '/'
    click_on 'RSVP'
    fill_in 'First Name', with: 'Jared'
    fill_in 'Last Name', with: 'Platzer'
    click_on 'Find me'
    expect(page).to have_content('Jared Platzer +1')
    click_on "Répondez S'il Vous Plaît"
    choose 'will be attending', match: :first
    # both are default true :( would love to update this test to be more explicit
    click_on "Répondez S'il Vous Plaît"
    expect(page).to have_content('You have submitted an RSVP for 2')
    expect(page).to_not have_link("Répondez S'il Vous Plaît")
    expect(page).to have_link('Update my RSVP')
  end

  scenario 'User who is not found is redirected to index 3 times, then l/e is emailed' do
    visit '/'
    click_on 'RSVP'
    fill_in 'First Name', with: 'Frank'
    fill_in 'Last Name', with: 'Sinatra'
    click_on 'Find me'
    expect(page).to have_content('Oh no! We could not find your record. Try again.')
    fill_in 'First Name', with: 'Frank'
    fill_in 'Last Name', with: 'Sinatra'
    click_on 'Find me'
    expect(page).to have_content('Oh no! We could not find your record. Try again.')
    fill_in 'First Name', with: 'Frank'
    fill_in 'Last Name', with: 'Sinatra'
    click_on 'Find me'
    expect(page).to have_content('Still could not find you. An email was sent to Emily and Luke, we will be in touch!')
  end
end
