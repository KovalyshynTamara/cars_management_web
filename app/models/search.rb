class Search < ApplicationRecord
  belongs_to :user

  validates :rules, presence: true
end
