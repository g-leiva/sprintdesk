class User < ApplicationRecord
    has_secure_password

    has_many :team_memberships, dependent: :destroy
    has_many :teams, through: :team_memberships
    has_many :assigned_tasks, class_name: "Task", foreign_key: "assignee_id", dependent: :nullify
    has_many :created_tasks, class_name: "Task", foreign_key: "creator_id", dependent: :nullify

    validates :name, presence: true
    validates :email, presence: true,
                        uniqueness: { case_sensitive: false },
                        format: { with: URI::MailTo::EMAIL_REGEXP }

    before_save { self.email = email.downcase }
end
