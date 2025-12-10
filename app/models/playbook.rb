# == Schema Information
#
# Table name: playbooks
#
#  id                    :bigint           not null, primary key
#  playbook_name         :string
#  plays_playbooks_count :integer
#  side_of_ball          :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  scheme_id             :integer
#  user_id               :integer
#
class Playbook < ApplicationRecord
  has_many  :plays_playbooks, class_name: "PlaysPlaybook", foreign_key: "playbook_id", dependent: :destroy
  has_many  :playsheets, class_name: "Playsheet", foreign_key: "playbook_id", dependent: :destroy
  belongs_to :user, class_name: "User", foreign_key: "user_id", counter_cache: true
  belongs_to :scheme, required: true, class_name: "Scheme", foreign_key: "scheme_id"
  has_many :plays, through: :plays_playbooks, source: :play
  def self.ransackable_attributes(_auth_object = nil)
    ["id", "playbook_name", "side_of_ball"]
  end
    def self.ransackable_associations(auth_object = nil)
    # Let's allow filtering by the director and actors associations; but not by characters
    ["play", "playsheet", "plays_playbook"]
  end
end
