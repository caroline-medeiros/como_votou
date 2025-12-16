class CreateVotes < ActiveRecord::Migration[8.1]
  def change
    create_table :votes do |t|
      t.references :voting, null: false, foreign_key: true
      t.references :deputy, null: false, foreign_key: true
      t.string :vote_type

      t.timestamps
    end
    add_index :votes, [ :voting_id, :deputy_id ], unique: true
  end
end
