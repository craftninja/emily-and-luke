class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.timestamps
    end
  end
end
