# == Schema Information
#
# Table name: plays_concepts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  concept_id :integer
#  play_id    :integer
#
class PlaysConcept < ApplicationRecord
  belongs_to :play, required: true, class_name: "Play", foreign_key: "play_id"
  belongs_to :concept, required: true, class_name: "Concept", foreign_key: "concept_id"
end
