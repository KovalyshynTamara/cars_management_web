class Car < ApplicationRecord
  validates :make, presence: true,
                   length: { minimum: 3, maximum: 50 },
                   format: { with: /\A[A-Za-z]+\z/ }

  validates :model, presence: true,
                    length: { minimum: 3, maximum: 50 },
                    format: { with: /\A[A-Za-z]+\z/ }

  validates :year, presence: true,
                   numericality: { only_integer: true,
                                   greater_than_or_equal_to: 1901,
                                   less_than_or_equal_to: ->(_) { Time.current.year } }

  validates :odometer, presence: true,
                       numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :description, length: { maximum: 5000 }, allow_nil: true

  before_create :set_date_added

  private

  def set_date_added
    self.date_added ||= Date.today
  end
end
