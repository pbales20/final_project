# == Schema Information
#
# Table name: schemes
#
#  id           :bigint           not null, primary key
#  description  :string
#  name         :string
#  side_of_ball :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Scheme < ApplicationRecord
  has_many  :playbooks, class_name: "Playbook", foreign_key: "scheme_id", dependent: :destroy
  has_many  :schemes_concepts, class_name: "SchemesConcept", foreign_key: "scheme_id", dependent: :destroy
  has_many :concepts, through: :schemes_concepts, source: :concept
end
