require 'spec_helper'

describe 'FamilyMember' do
  it 'requires a family id and user id' do
    u = create_user
    f = create_family

    fm = FamilyMembership.new
    expect(fm.valid?).to be(false)
    fm.family_id = f.id
    expect(fm.valid?).to be(false)
    fm.user_id = u.id
    expect(fm.valid?).to be(true)
  end
end
