class Profile < ApplicationRecord
  validates :name, presence: true, length: { maximum: 40 }, uniqueness: true

  has_many :user_profiles
  has_many :users, through: :user_profiles
end
