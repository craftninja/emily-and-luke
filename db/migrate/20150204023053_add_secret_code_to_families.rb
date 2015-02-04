class AddSecretCodeToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :secret_code, :string, null: false
  end
end
