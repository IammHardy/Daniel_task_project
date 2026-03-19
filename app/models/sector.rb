class Sector < ApplicationRecord
  belongs_to :company
  has_many :users, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :company_id, presence: true
end