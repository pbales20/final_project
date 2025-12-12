# == Schema Information
#
# Table name: plays
#
#  id               :bigint           not null, primary key
#  description      :string
#  play             :string
#  play_art         :string
#  side_of_ball     :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  formation_set_id :integer
#
class Play < ApplicationRecord
  has_many  :plays_playbooks, class_name: "PlaysPlaybook", foreign_key: "play_id", dependent: :destroy
  has_many  :plays_playsheets, class_name: "PlaysPlaysheet", foreign_key: "play_id", dependent: :destroy
  has_many  :plays_concepts, class_name: "PlaysConcept", foreign_key: "play_id", dependent: :destroy
  belongs_to :formation_set, required: true, class_name: "FormationSet", foreign_key: "formation_set_id", counter_cache: true
  has_one :formation, through: :formation_set
  has_many :playbooks, through: :plays_playbooks, source: :playbook
  has_many :playsheets, through: :plays_playsheets, source: :playsheet
  has_many :concepts, through: :plays_concepts, source: :concept
has_many :playfavorites, dependent: :destroy
has_many :favorited_by_users, through: :playfavorites, source: :user

has_many :favorited_by_users, through: :playfavorites, source: :user

  def self.ransackable_attributes(auth_object = nil)
    [ "play", "description", "side_of_ball", "formation_set_id" ]
  end
    def self.ransackable_associations(auth_object = nil)
    # Let's allow filtering by the director and actors associations; but not by characters
    [ "formation", "formation_set", "playbooks", "plays_playbooks", "plays_playsheets", "playsheets" ]
  end
end
