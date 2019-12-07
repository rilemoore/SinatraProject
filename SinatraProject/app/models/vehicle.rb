class Vehicle < ActiveRecord::Base
    belongs_to :user
    validates :make, presence: true
    validates :model, presence: true
    validates :money_invested, presence: true
    validates :money_invested, numericality: {greater_than_or_equal_to: 0}
end
  