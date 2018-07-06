class CreateGifts < ActiveRecord::Migration[4.2]
  def change
    create_table :gifts do |t|
      t.string :description, null: false
      t.belongs_to :family, null: false
      t.boolean :thank_you_sent, default: false, null: false
      t.timestamps
    end
  end
end
