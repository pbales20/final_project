# == Schema Information
#
# Table name: plays_playsheets
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  play_id      :integer
#  playsheet_id :integer
#
class PlaysPlaysheet < ApplicationRecord
  belongs_to :play, required: true, class_name: "Play", foreign_key: "play_id"
  belongs_to :playsheet, required: true, class_name: "Playsheet", foreign_key: "playsheet_id"
end
