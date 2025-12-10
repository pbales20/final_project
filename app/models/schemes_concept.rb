# == Schema Information
#
# Table name: schemes_concepts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  concept_id :integer
#  scheme_id  :integer
#
class SchemesConcept < ApplicationRecord
  belongs_to :scheme, required: true, class_name: "Scheme", foreign_key: "scheme_id"
  belongs_to :concept, required: true, class_name: "Concept", foreign_key: "concept_id"
end
