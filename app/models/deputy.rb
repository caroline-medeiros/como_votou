class Deputy < ApplicationRecord
  belongs_to :party
  has_many :votes
  has_many :votings, through: :votes
end
