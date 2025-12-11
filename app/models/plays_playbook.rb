# == Schema Information
#
# Table name: plays_playbooks
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  play_id     :integer
#  playbook_id :integer
#
class PlaysPlaybook < ApplicationRecord
  belongs_to :play, required: true, class_name: "Play", foreign_key: "play_id"
  belongs_to :playbook, required: true, class_name: "Playbook", foreign_key: "playbook_id", counter_cache: true
  def self.ransackable_attributes(auth_object = nil)
    [ "playbook_id", "play_id" ]
  end
    def self.ransackable_associations(auth_object = nil)
    # Let's allow filtering by the director and actors associations; but not by characters
    [ "play", "playbook" ]
  end
end
