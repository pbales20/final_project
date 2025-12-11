# == Schema Information
#
# Table name: playsheets
#
#  id             :bigint           not null, primary key
#  playsheet_name :string
#  side_of_ball   :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  playbook_id    :integer
#  user_id        :integer
#
class Playsheet < ApplicationRecord
  belongs_to :playbook, required: true, class_name: "Playbook", foreign_key: "playbook_id"
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id", counter_cache: true
  has_many :plays_playsheets, class_name: "PlaysPlaysheet", foreign_key: "playsheet_id", dependent: :destroy
  has_many :plays, through: :plays_playsheets, source: :play
end
