class CreatePlays < ActiveRecord::Migration[8.0]
  def change
    create_table :plays do |t|
      t.string :play
      t.integer :formation_set_id
      t.string :play_art
      t.string :side_of_ball
      t.string :description

      t.timestamps
    end
  end
end
