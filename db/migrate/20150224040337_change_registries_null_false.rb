class ChangeRegistriesNullFalse < ActiveRecord::Migration
  def change
    change_column_null :registries, :description, false
    change_column_null :registries, :url, false
    change_column_null :registries, :title, false
    change_column_null :registries, :img_url, false
  end
end
