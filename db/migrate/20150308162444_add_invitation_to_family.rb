class AddInvitationToFamily < ActiveRecord::Migration[4.2]

  class MigrationFamily < ActiveRecord::Base
    self.table_name = :families
  end

  def change
    add_column :families, :invitation, :boolean
    MigrationFamily.reset_column_information
    MigrationFamily.all.each do |family|
      family.update(invitation: false)
    end
    change_column_null :families, :invitation, false
    change_column_default :families, :invitation, false
  end
end
