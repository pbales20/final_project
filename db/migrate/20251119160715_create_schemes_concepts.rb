class CreateSchemesConcepts < ActiveRecord::Migration[8.0]
  def change
    create_table :schemes_concepts do |t|
      t.integer :scheme_id
      t.integer :concept_id

      t.timestamps
    end
  end
end
