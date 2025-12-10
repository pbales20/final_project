class CreatePersonnelGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :personnel_groups do |t|
      t.string :name
      t.integer :number_of_tight_ends
      t.integer :number_of_running_backs
      t.integer :number_of_wide_receivers
      t.integer :number_of_defensive_linemen
      t.string :number_of_linebackers
      t.integer :number_of_cornerbacks
      t.integer :number_of_safeties
      t.string :side_of_ball

      t.timestamps
    end
  end
end
