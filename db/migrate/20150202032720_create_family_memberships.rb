class CreateFamilyMemberships < ActiveRecord::Migration
  def change
    create_table :family_memberships do |t|
      t.belongs_to :family
      t.belongs_to :user
      t.timestamps
    end
  end
end
