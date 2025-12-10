# == Schema Information
#
# Table name: concepts
#
#  id           :bigint           not null, primary key
#  description  :string
#  name         :string
#  side_of_ball :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Concept < ApplicationRecord
  has_many  :schemes_concepts, class_name: "SchemesConcept", foreign_key: "concept_id", dependent: :destroy
  has_many  :plays_concepts, class_name: "PlaysConcept", foreign_key: "concept_id", dependent: :destroy
  has_many :schemes, through: :schemes_concepts, source: :scheme
  has_many :plays, through: :plays_concepts, source: :play
end
