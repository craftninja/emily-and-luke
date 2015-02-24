require 'spec_helper'

describe 'Family' do
  it 'validates presence of secret code' do
    family = Family.new
    expect(family.valid?).to be(false)
    family.secret_code = 'socks'
    expect(family.valid?).to be(true)
  end
end
