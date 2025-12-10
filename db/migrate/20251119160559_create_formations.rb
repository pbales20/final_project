class CreateFormations < ActiveRecord::Migration[8.0]
  def change
    create_table :formations do |t|
      t.string :formation_name
      t.string :formation_art
      t.string :description
      t.string :side_of_ball
      t.integer :formation_sets_count

      t.timestamps
    end
  end
end
