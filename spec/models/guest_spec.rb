require 'spec_helper'

describe 'Guest' do
  it 'validates presence of first and last name' do
    guest = Guest.new
    expect(guest.valid?).to be(false)
    guest.first_name = 'Jared'
    expect(guest.valid?).to be(false)
    guest.last_name = 'Platzer'
    expect(guest.valid?).to be(true)
  end
end
