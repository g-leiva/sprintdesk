class Column < ApplicationRecord
  belongs_to :sprint
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :position, presence: true, numericality: { only_integer: true, greater_than: 0 }, uniqueness: { scope: :sprint_id }

  scope :ordered, -> { order(position: :asc) }

  def self.default_columns_for(sprint)
    [
      { name: "To Do", position: 1 },
      { name: "In Progress", position: 2 },
      { name: "Done", position: 3 }
    ].map { |attrs| sprint.columns.create!(attrs) }
  end
end
