class ExpenseUser < ApplicationRecord
  belongs_to :expense, counter_cache: :number_of_participants
  belongs_to :user
end
