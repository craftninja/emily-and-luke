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
    pending
    visit '/'
    click_on 'RSVP'
    fill_in 'First name', with: 'Jared'
    fill_in 'Last name', with: 'Platzer'
    click_on 'Find me'
    expect(page).to have_content('Jared Platzer +1')
    click_on "Répondez S'il Vous Plaît"
    select '2', from: 'The size of my party will be'
    click_on "Répondez S'il Vous Plaît"
    expect(page).to have_content('You have submitted an RSVP for 2')
    expect(page).to_not have_button("Répondez S'il Vous Plaît")
    expect(page).to have_button('Update RSVP')
  end
end
