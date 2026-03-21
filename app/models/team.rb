class Team < ApplicationRecord
    has_many :team_memberships, dependent: :destroy
    has_many :users, through: :team_memberships
    has_many :sprints, dependent: :destroy

    validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 50 }
    validates :description, length: { maximum: 500 }

    def owner?(user)
        team_memberships.exists?(user: user, role: "owner")
    end

    def member?(user)
        team_memberships.exists?(user: user)
    end
end
