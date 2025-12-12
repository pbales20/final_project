class CreateScenarios < ActiveRecord::Migration[8.0]
  def change
    create_table :scenarios do |t|
      t.string :name
      t.string :description
      t.string :side_of_ball

      t.timestamps
    end
  end
end
