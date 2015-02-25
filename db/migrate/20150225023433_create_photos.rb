class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :img_url, null: false
      t.date :date, null: false
      t.string :caption
      t.timestamps
    end
  end
end
