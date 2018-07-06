class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email
      t.boolean :attending
      t.string :dietary_restrictions
      t.timestamps
    end
  end
end
