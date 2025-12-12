# == Schema Information
#
# Table name: playfavorites
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  play_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_playfavorites_on_play_id              (play_id)
#  index_playfavorites_on_user_id              (user_id)
#  index_playfavorites_on_user_id_and_play_id  (user_id,play_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (play_id => plays.id)
#  fk_rails_...  (user_id => users.id)
#
class Playfavorite < ApplicationRecord
  belongs_to :user
  belongs_to :play
end

