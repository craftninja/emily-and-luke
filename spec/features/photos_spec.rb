require 'rails_helper'

feature 'Photos - ' do
  scenario 'User can see photos' do
    visit '/'
    click_on 'Photos'
    expect(page).to have_css('.thumbnail')
  end
end
