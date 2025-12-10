class CreateFormationSets < ActiveRecord::Migration[8.0]
  def change
    create_table :formation_sets do |t|
      t.integer :formation_id
      t.string :formation_set
      t.integer :personnel_group_id
      t.string :set_art
      t.string :description
      t.integer :plays_count

      t.timestamps
    end
  end
end
