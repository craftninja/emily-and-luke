require 'rails_helper'

feature 'Welcome page - ' do
  scenario 'User is greeted on homepage' do
    visit '/'
    within '.container' do
      within '.jumbotron' do
        expect(page).to have_content('Emily and Luke')
        expect(page).to have_content('May 16th, 2015')
        expect(page).to have_content('Lyons, Colorado')
      end
    end
    within '.nav' do
      expect(page).to have_link('Our Wedding')
      expect(page).to have_link('Photos')
      expect(page).to have_link('RSVP')
      expect(page).to have_link('Registry')
    end
    click_on 'Our Wedding'
    expect(page).to_not have_content('May 16th, 2015')
    expect(page).to_not have_content('Lyons, Colorado')
  end
end
