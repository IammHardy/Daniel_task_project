class Task < ApplicationRecord
  belongs_to :manager, class_name: "User"
  belongs_to :employee, class_name: "User"
  belongs_to :sector
  belongs_to :company
  has_many_attached :documents

  enum status: {
    pending: 0,
    in_progress: 1,
    review: 2,
    completed: 3
  }

  enum :status, {
    pending: 0,
    in_progress: 1,
    review: 2,
    completed: 3
  }

  enum :priority, {
    low: 0,
    medium: 1,
    high: 2,
    urgent: 3
  }

end
