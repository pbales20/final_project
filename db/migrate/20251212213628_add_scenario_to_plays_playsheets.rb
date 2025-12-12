class AddScenarioToPlaysPlaysheets < ActiveRecord::Migration[8.0]
  def change
    add_reference :plays_playsheets, :scenario, null: true, foreign_key: true
  end
end
