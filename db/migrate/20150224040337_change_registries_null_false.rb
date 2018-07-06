class ChangeRegistriesNullFalse < ActiveRecord::Migration[4.2]
  def change
    change_column_null :registries, :description, false
    change_column_null :registries, :url, false
    change_column_null :registries, :title, false
    change_column_null :registries, :img_url, false
  end
end
