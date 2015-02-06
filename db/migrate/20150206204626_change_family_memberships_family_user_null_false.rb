class ChangeFamilyMembershipsFamilyUserNullFalse < ActiveRecord::Migration
  def change
    change_column_null :family_memberships, :family_id, false
    change_column_null :family_memberships, :user_id, false
  end
end
