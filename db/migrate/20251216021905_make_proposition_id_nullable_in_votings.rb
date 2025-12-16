class MakePropositionIdNullableInVotings < ActiveRecord::Migration[8.1]
  def change
    change_column_null :votings, :proposition_id, true
  end
end
