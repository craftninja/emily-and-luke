require 'rails_helper'

feature 'Photos - ' do
  scenario 'User can see photos' do
    photo = create_photo
    photo_date = photo.date.strftime("%B %Y")
    visit '/'
    click_on 'Photos'
    expect(page).to have_css('.thumbnail')
    expect(page).to_not have_content('Add Photo')
    expect(page).to_not have_content('Edit')
    expect(page).to_not have_content('Delete')
    click_on photo_date
    within '.page-header' do
      expect(page).to have_content(photo_date)
      expect(page).to have_content(photo.caption)
    end
    visit new_photo_path
    expect(page).to_not have_content('New Photo')
    expect(page).to have_content('Oops! That does not exist')
    within '.jumbotron' do
      expect(page).to have_content('Emily and Luke')
    end
  end

  scenario 'Admin can manage photos' do
    login
    visit photos_path
    within '.page-header' do
      click_on 'Add Photo'
    end
    within '.page-header' do
      expect(page).to have_content('New Photo')
    end
    click_on 'Add this Photo'
    expect(page).to have_content("Img url can't be blank Date can't be blank")
    fill_in 'Image URL', with: 'https://s3-us-west-2.amazonaws.com/emily-and-luke/registry_logo_amazon.png'
    fill_in 'Date', with: Date.today
    fill_in 'Caption', with: 'Hey, wait, that is a logo'
    click_on 'Add this Photo'
    expect(page).to have_content('Photo was successfully added')
    expect(page).to have_content(Date.today.strftime("%B %Y"))
    expect(page).to have_content('Hey, wait, that is a logo')
    click_on 'Edit'
    fill_in 'Caption', with: 'Where is the photo'
    click_on 'Update this Photo'
    expect(page).to have_content('Photo was successfully updated')
    expect(page).to_not have_content('Hey, wait, that is a logo')
    expect(page).to have_content('Where is the photo')
    click_on 'Delete'
    expect(page).to have_content('Photo was successfully deleted')
    expect(page).to_not have_content('Where is the photo')
  end

end
