require 'family'
require 'guest'
require 'family_membership'

describe 'FamilyMembership -' do
  it 'requires a family id and user id' do
    g = create_guest
    f = create_family

    fm = FamilyMembership.new
    expect(fm.valid?).to be(false)
    fm.family_id = f.id
    expect(fm.valid?).to be(false)
    fm.guest_id = f.id
    expect(fm.valid?).to be(true)
  end

  it 'self-destructs when guest is deleted' do
    g = create_guest
    f = create_family

    FamilyMembership.create!(
      :family_id => f.id,
      :guest_id => g.id
    )
    expect(FamilyMembership.where(:family => f.id).any?).to be(true)

    g.destroy
    expect(FamilyMembership.where(:family => f.id).any?).to be(false)
  end
end
