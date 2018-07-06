class AddSecretCodeToFamilies < ActiveRecord::Migration[4.2]
  def change
    add_column :families, :secret_code, :string, null: false
  end
end
