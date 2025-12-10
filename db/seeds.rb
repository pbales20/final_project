# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "csv"

file_path = Rails.root.join("db", "seeds", "plays_playbooks.csv")

puts "Importing plays from #{file_path}..."

CSV.foreach(file_path, headers: true) do |row|
  PlaysPlaybook.find_or_create_by!(
    play_id:            row["Play_Id"],
    playbook_id: row["Playbook ID"],  
  )
end

puts "Done importing formations!"

