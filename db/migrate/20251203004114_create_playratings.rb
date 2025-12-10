class CreatePlayratings < ActiveRecord::Migration[8.0]
  def change
    create_table :playratings do |t|
      t.integer :play_id
      t.integer :user_id
      t.boolean :favorite

      t.timestamps
    end
  end
end
