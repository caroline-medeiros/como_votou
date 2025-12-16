class Vote < ApplicationRecord
  belongs_to :voting
  belongs_to :deputy

  validates :deputy_id, uniqueness: { scope: :voting_id, message: "has already voted in this voting session" }
end
