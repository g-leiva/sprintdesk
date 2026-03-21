class Priority < ApplicationRecord
    has_many :tasks

    validates :name, presence: true, uniqueness: true
    validates :color, presence: true, format: { with: /\A#[0-9A-Fa-f]{6}\z/,
                                        message: "Debe ser un valor hexadecimal válido (ej. #FF0000)" }
    validates :level, presence: true,
                        uniqueness: true,
                        numericality: { only_integer: true, greater_than: 0 }

    scope :ordered, -> { order(level: :asc) }

    def self.default
        ordered.first
    end
end
