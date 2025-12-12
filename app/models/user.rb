# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  full_name              :string
#  playbooks_count        :integer
#  playsheets_count       :integer
#  psn_username           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  xbox_gamertag          :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many  :playsheets, class_name: "Playsheet", foreign_key: "user_id", dependent: :destroy
  has_many :playfavorites, dependent: :destroy
has_many :favorite_plays, through: :playfavorites, source: :play

  has_many  :playbooks, class_name: "Playbook", foreign_key: "user_id"
  has_many  :playratings, class_name: "Playrating", foreign_key: "user_id", dependent: :destroy
end
