class ChangeApiIdToStringInVotings < ActiveRecord::Migration[7.1]
  def up
    change_column :votings, :api_id, :string
    change_column :parties, :api_id, :string
    change_column :deputies, :api_id, :string
    change_column :propositions, :api_id, :string
  end

  def down
    change_column :votings, :api_id, :integer
  end
end
