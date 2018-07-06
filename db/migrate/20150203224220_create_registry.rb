class CreateRegistry < ActiveRecord::Migration[4.2]
  def change
    create_table :registries do |t|
      t.string :img_url
      t.string :title
      t.string :url
      t.text :description
      t.timestamps
    end
  end
end
