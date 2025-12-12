# == Schema Information
#
# Table name: scenarios
#
#  id           :bigint           not null, primary key
#  description  :string
#  name         :string
#  side_of_ball :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Scenario < ApplicationRecord
  has_many  :plays_playsheets, class_name: "PlaysPlaysheet", foreign_key: "scenario_id", dependent: :nullify
has_many  :playratings, class_name: "Playrating", foreign_key: "scenario_id", dependent: :destroy
end
