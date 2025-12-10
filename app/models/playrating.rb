# == Schema Information
#
# Table name: playratings
#
#  id         :bigint           not null, primary key
#  favorite   :boolean
#  rating     :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  play_id    :integer
#  user_id    :integer
#
class Playrating < ApplicationRecord
  belongs_to :play, required: true, class_name: "Play", foreign_key: "play_id"
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"

  validates :user_id, uniqueness: { scope: :play_id }

  # rating is optional, but if present:
  validates :rating, numericality: true,
                     allow_nil: true

  validate :rating_in_half_star_steps

  private

  def rating_in_half_star_steps
    return if rating.nil?

    unless rating >= 0.5 && rating <= 5.0
      errors.add(:rating, "must be between 0.5 and 5.0")
    end

    # enforce multiples of 0.5
    unless ((rating * 2) % 1).zero?
      errors.add(:rating, "must be in 0.5-star increments")
    end
  end
end
