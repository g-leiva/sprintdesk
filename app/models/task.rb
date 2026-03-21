class Task < ApplicationRecord
  belongs_to :column
  belongs_to :priority, optional: true
  belongs_to :assignee, class_name: "User", optional: true
  belongs_to :creator, class_name: "User"

  validates :title, presence: true, length: { minimum: 2, maximum: 255 }
  validates :position, numericality: { only_integer: true, greater_than: 0, allow_nil: true }
  validates :position, uniqueness: { scope: column_id }, allow_nil: true

  scope :ordered,      -> { order(position: :asc) }
  scope :unassigned,   -> { where(assignee_id: nil) }
  scope :assigned_to,  ->(user) { where(assignee_id: user.id) }
  scope :by_priority,  -> { joins(:priority).order("priorities.level asc") }

  def assigned?
    assignee_id.present?
  end

  def overdue?
    due_date.present? && due_date < Date.today
  end

  def move_to_column!(new_column)
    update!(column: new_column, position: new_column.tasks.count + 1)
  end
end
