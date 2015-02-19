class RenameUsersToGuests < ActiveRecord::Migration
  def change
    rename_table :users, :guests
    rename_column :family_memberships, :user_id, :guest_id
  end
end
