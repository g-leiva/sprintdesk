class Sprint < ApplicationRecord
  belongs_to :team
  has_many :columns, dependent: :destroy
  has_many :tasks, through: :columns

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date

  scope :active, -> { where("start_date <= ? AND end_date >= ?", Date.today, Date.today) }
  scope :upcoming, -> { where("start_date > ?", Date.today) }
  scope :past, -> { where("end_date < ?", Date.today) }

  def active?
    start_date <= Date.today && end_date >= Date.today
  end

  def duration_in_days
    (end_date - start_date).to_i
  end

  private

  def end_date_after_start_date
    return unless start_date && end_date
    if end_date <= start_date
      errors.add(:end_date, "Debe ser mayor a la fecha de inicio")
    end
  end
end
