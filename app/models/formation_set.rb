# == Schema Information
#
# Table name: formation_sets
#
#  id                 :bigint           not null, primary key
#  description        :string
#  formation_set      :string
#  plays_count        :integer
#  set_art            :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  formation_id       :integer
#  personnel_group_id :integer
#
class FormationSet < ApplicationRecord
  belongs_to :formation, required: true, class_name: "Formation", foreign_key: "formation_id", counter_cache: true
  has_many  :plays, class_name: "Play", foreign_key: "formation_set_id", dependent: :destroy
  has_many  :packages, class_name: "Package", foreign_key: "formation_set_id", dependent: :destroy
  belongs_to :personnel_group, required: true, class_name: "PersonnelGroup", foreign_key: "personnel_group_id"
   def self.ransackable_attributes(auth_object = nil)
    [ "formation_set", "description", "formation_id" ]
  end
  def self.ransackable_associations(auth_object = nil)
    # Let's allow filtering by the director and actors associations; but not by characters
    [ "play", "formation" ]
  end
end
