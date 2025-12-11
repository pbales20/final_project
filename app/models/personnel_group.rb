# == Schema Information
#
# Table name: personnel_groups
#
#  id                          :bigint           not null, primary key
#  name                        :string
#  number_of_cornerbacks       :integer
#  number_of_defensive_linemen :integer
#  number_of_linebackers       :string
#  number_of_running_backs     :integer
#  number_of_safeties          :integer
#  number_of_tight_ends        :integer
#  number_of_wide_receivers    :integer
#  side_of_ball                :string
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#
class PersonnelGroup < ApplicationRecord
  has_many :formation_sets, class_name: "FormationSet", foreign_key: "personnel_group_id", dependent: :destroy
end
