class ChangeFamilyMembershipsFamilyUserNullFalse < ActiveRecord::Migration[4.2]
  def change
    change_column_null :family_memberships, :family_id, false
    change_column_null :family_memberships, :user_id, false
  end
end
