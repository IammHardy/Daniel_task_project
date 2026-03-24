class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles
  enum :role, { admin: 0, manager: 1, employee: 2 }


  # Associations
  belongs_to :company
  belongs_to :sector, optional: true
  belongs_to :manager, class_name: "User", optional: true
  has_many :employees, class_name: "User", foreign_key: "manager_id"

  # Employee -> tasks
  has_many :tasks_as_employee, class_name: "Task", foreign_key: "employee_id"
has_many :tasks_as_manager, class_name: "Task", foreign_key: "manager_id"
  # Validations
  validates :name, presence: true
  validates :company, presence: true

  # Callbacks
  after_create :mark_password_not_changed

  def mark_password_not_changed
    update_column(:password_changed, false)
  end

  # OAuth
  def self.from_omniauth(auth)
    user = find_by(email: auth.info.email)

    if user
      user.update(
        google_uid: auth.uid,
        google_token: auth.credentials.token,
        google_refresh_token: auth.credentials.refresh_token
      )
    end

    user
  end
end