# == Schema Information
#
# Table name: formations
#
#  id                   :bigint           not null, primary key
#  description          :string
#  formation_art        :string
#  formation_name       :string
#  formation_sets_count :integer
#  side_of_ball         :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Formation < ApplicationRecord
  has_many :formation_sets, class_name: "FormationSet", foreign_key: "formation_id", dependent: :destroy
  has_many :plays, through: :formation_sets
  def self.ransackable_attributes(auth_object = nil)
    [ "formation_name", "description", "side_of_ball" ]
  end
  def self.ransackable_associations(auth_object = nil)
    # Let's allow filtering by the director and actors associations; but not by characters
    [ "play", "formation_set" ]
  end
end
