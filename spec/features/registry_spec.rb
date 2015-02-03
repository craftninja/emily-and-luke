require 'rails_helper'

feature 'Registry - ' do
  scenario 'User can see list of registry information' do
    registry = create_registry
    visit '/'
    click_on 'Registry'
    within '.page-header' do
      expect(page).to have_content('Registries')
    end
    expect(page).to have_link(registry.title)
    expect(page).to have_content(registry.title)
  end
end
