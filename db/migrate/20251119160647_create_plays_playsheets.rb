class CreatePlaysPlaysheets < ActiveRecord::Migration[8.0]
  def change
    create_table :plays_playsheets do |t|
      t.integer :playsheet_id
      t.integer :play_id

      t.timestamps
    end
  end
end
