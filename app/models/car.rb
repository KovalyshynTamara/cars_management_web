class Car < ApplicationRecord
  NAME_LENGTH_RANGE = 3..50
  NAME_FORMAT       = /\A[A-Za-z]+\z/
  MIN_YEAR          = 1901
  MIN_NUMBER        = 0
  MAX_DESCRIPTION   = 5000

  attribute :date_added, :date, default: -> { Date.current }

  with_options presence: true,
               length: { in: NAME_LENGTH_RANGE },
               format: { with: NAME_FORMAT } do
    validates :make
    validates :model
  end

  validates :year,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: MIN_YEAR,
              less_than_or_equal_to: ->(_) { Time.current.year }
            }

  validates :odometer,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: MIN_NUMBER
            }

  validates :price,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: MIN_NUMBER
            }

  validates :description,
            length: { maximum: MAX_DESCRIPTION },
            allow_nil: true
end
