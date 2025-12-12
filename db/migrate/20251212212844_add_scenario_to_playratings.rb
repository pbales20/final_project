class AddScenarioToPlayratings < ActiveRecord::Migration[8.0]
  def change
    add_reference :playratings, :scenario, null: false, foreign_key: true
  end
end
