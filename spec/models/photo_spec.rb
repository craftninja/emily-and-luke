require 'photo'

describe 'Photo -' do
  it 'validates presence of image url, date' do
    photo = Photo.new
    expect(photo.valid?).to be(false)
    photo.img_url = 'fake.jpg'
    expect(photo.valid?).to be(false)
    photo.date = Date.today
    expect(photo.valid?).to be(true)
  end
end
