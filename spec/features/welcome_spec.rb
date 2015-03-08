require 'rails_helper'

feature 'Welcome page - ' do
  scenario 'User is greeted on homepage' do
    visit '/'
    within '.nav' do
      expect(page).to have_link('Our Wedding')
      expect(page).to have_link('Photos')
      expect(page).to have_link('RSVP')
      expect(page).to have_link('Registry')
    end
  end
end
