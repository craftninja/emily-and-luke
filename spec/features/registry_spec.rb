require 'rails_helper'

feature 'Registry - ' do
  scenario 'User can see list of registry information, no access to management' do
    registry = create_registry
    visit '/'
    click_on 'Registry'
    within '.page-header' do
      expect(page).to have_content('Registries')
    end
    expect(page).to have_link(registry.title)
    expect(page).to have_content(registry.title)
    expect(page).to_not have_content('Add Registry')
    expect(page).to_not have_content('Edit')
    expect(page).to_not have_content('Delete')
    visit new_registry_path
    expect(page).to have_content('Oops! That does not exist')
    expect(current_path).to eq root_path
    expect(page).to_not have_content('New Registry')
  end

  scenario 'Admin can manage registries' do
    login
    visit registries_path
    within '.page-header' do
      click_on 'Add Registry'
    end
    within '.page-header' do
      expect(page).to have_content('New Registry')
    end
    click_on 'Create this Registry'
    expect(page).to have_content("Img url can't be blank Title can't be blank Url can't be blank Description can't be blank")
    fill_in 'Image URL', with: 'https://s3-us-west-2.amazonaws.com/emily-and-luke/registry_logo_amazon.png'
    fill_in 'Title', with: 'Amazing'
    fill_in 'URL', with: 'http://www.amazon.com/registry/wedding/38P8RW2N4NIIM'
    fill_in 'Description', with: 'Some great things from the store that has almost everything'
    click_on 'Create this Registry'
    expect(page).to have_content('Registry was successfully created')
    expect(page).to have_content('Amazing')
    expect(page).to have_content('Some great things from the store that has almost everything')
    click_on 'Edit'
    fill_in 'Title', with: 'Amazon.com'
    click_on 'Update this Registry'
    expect(page).to have_content('Registry was successfully updated')
    expect(page).to_not have_content('Amazing')
    expect(page).to have_content('Amazon.com')
    click_on 'Delete'
    expect(page).to have_content('Registry was successfully deleted')
    expect(page).to_not have_content('Amazon.com')
  end
end
