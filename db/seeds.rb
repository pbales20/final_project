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

csv_path = Rails.root.join("db", "seeds", "playbooks.csv")

CSV.foreach(csv_path, headers: true) do |row|
  attrs = row.to_h

  playbook = Playbook.find_or_initialize_by(
    playbook_name: attrs["playbook_name"],
    side_of_ball:  attrs["side_of_ball"],
    user_id:       attrs["user_id"]
  )

  playbook.scheme_id = attrs["scheme_id"]

  unless playbook.save
    puts "FAILED: #{attrs.inspect} -> #{playbook.errors.full_messages.join(", ")}"
  end
end
