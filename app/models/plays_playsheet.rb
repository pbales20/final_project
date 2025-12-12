# == Schema Information
#
# Table name: plays_playsheets
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  play_id      :integer
#  playsheet_id :integer
#  scenario_id  :bigint
#
# Indexes
#
#  index_plays_playsheets_on_scenario_id  (scenario_id)
#
# Foreign Keys
#
#  fk_rails_...  (scenario_id => scenarios.id)
#
class PlaysPlaysheet < ApplicationRecord
  belongs_to :play, required: true, class_name: "Play", foreign_key: "play_id"
  belongs_to :playsheet, required: true, class_name: "Playsheet", foreign_key: "playsheet_id"
  belongs_to :scenario, class_name: "Scenario", foreign_key: "scenario_id"
end
