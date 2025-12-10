class AddRatingToPlayratings < ActiveRecord::Migration[7.0]
  def change
    add_column :playratings, :rating, :decimal, precision: 2, scale: 1
  end
end
