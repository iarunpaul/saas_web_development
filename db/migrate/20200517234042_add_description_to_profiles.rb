class AddDescriptionToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :description, :text
  end
end
