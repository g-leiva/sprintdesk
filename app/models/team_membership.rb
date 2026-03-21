class TeamMembership < ApplicationRecord
  belongs_to :user
  belongs_to :team

  ROLES = %w[owner member].freeze

  validates :role, presence: true, inclusion: { in: ROLES }
  validates :user_id, uniqueness: { scope: :team_id, message: "Usuario ya es parte del equipo" }
end
