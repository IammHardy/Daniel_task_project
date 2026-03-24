class Task < ApplicationRecord
  belongs_to :manager, class_name: "User"
  belongs_to :employee, class_name: "User"
  belongs_to :sector
  belongs_to :company

  has_many_attached :documents

  enum :status, { pending: 0, in_progress: 1, review: 2, completed: 3 }
  enum :priority, { low: 0, medium: 1, high: 2, urgent: 3 }

  validates :title, :employee_id, :manager_id, :sector_id, :company_id, presence: true
  validate :employee_and_manager_same_company

  def employee_and_manager_same_company
      # <-- execution will pause here
    return if employee.nil? || manager.nil?

    if employee.company_id != manager.company_id
      errors.add(:base, "must belong to same company as manager")
    end
  end
end