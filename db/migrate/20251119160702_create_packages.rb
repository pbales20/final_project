class CreatePackages < ActiveRecord::Migration[8.0]
  def change
    create_table :packages do |t|
      t.integer :formation_set_id
      t.string :name

      t.timestamps
    end
  end
end
