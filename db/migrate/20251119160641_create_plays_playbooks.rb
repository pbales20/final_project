class CreatePlaysPlaybooks < ActiveRecord::Migration[8.0]
  def change
    create_table :plays_playbooks do |t|
      t.integer :play_id
      t.integer :playbook_id

      t.timestamps
    end
  end
end
