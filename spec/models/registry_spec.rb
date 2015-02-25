require 'registry'

describe 'Registry -' do
  it 'validates presence of image url, title, url and description' do
    registry = Registry.new
    expect(registry.valid?).to be(false)
    registry.img_url = 'fake.jpg'
    expect(registry.valid?).to be(false)
    registry.title = 'Not a real thing'
    expect(registry.valid?).to be(false)
    registry.url = 'www.example.com'
    expect(registry.valid?).to be(false)
    registry.description = 'This is all crap data'
    expect(registry.valid?).to be(true)
  end
end
