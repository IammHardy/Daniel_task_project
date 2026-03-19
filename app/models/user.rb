class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
         enum :role, { admin: 0, manager: 1, employee: 2 }, default: :employee

belongs_to :company, optional: true
belongs_to :sector, optional: true
belongs_to :manager, class_name: "User", optional: true
has_many :employees, class_name: "User", foreign_key: "manager_id"
validates :name, presence: true
 # Called by Devise after OAuth login
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
