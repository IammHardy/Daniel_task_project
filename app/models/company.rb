class Company < ApplicationRecord
  has_many :sectors, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end