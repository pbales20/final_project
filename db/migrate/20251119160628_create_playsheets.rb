class CreatePlaysheets < ActiveRecord::Migration[8.0]
  def change
    create_table :playsheets do |t|
      t.integer :user_id
      t.string :playsheet_name
      t.string :side_of_ball
      t.integer :playbook_id

      t.timestamps
    end
  end
end
