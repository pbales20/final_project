class CreatePlaysConcepts < ActiveRecord::Migration[8.0]
  def change
    create_table :plays_concepts do |t|
      t.integer :play_id
      t.integer :concept_id

      t.timestamps
    end
  end
end
