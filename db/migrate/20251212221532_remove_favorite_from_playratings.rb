class RemoveFavoriteFromPlayratings < ActiveRecord::Migration[8.0]
  def change
    remove_column :playratings, :favorite, :boolean
  end
end
