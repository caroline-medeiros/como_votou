class Voting < ApplicationRecord
  belongs_to :proposition, optional: true
  has_many :votes, dependent: :destroy
  has_many :deputies, through: :votes
end
