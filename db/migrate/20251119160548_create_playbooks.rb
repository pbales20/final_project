class CreatePlaybooks < ActiveRecord::Migration[8.0]
  def change
    create_table :playbooks do |t|
      t.string :playbook_name
      t.string :side_of_ball
      t.integer :user_id
      t.integer :scheme_id
      t.integer :plays_playbooks_count

      t.timestamps
    end
  end
end
