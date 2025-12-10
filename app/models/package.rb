# == Schema Information
#
# Table name: packages
#
#  id               :bigint           not null, primary key
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  formation_set_id :integer
#
class Package < ApplicationRecord
  belongs_to :formation_set, required: true, class_name: "FormationSet", foreign_key: "formation_set_id"
end
