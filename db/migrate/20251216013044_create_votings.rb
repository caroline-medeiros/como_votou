class CreateVotings < ActiveRecord::Migration[8.1]
  def change
    create_table :votings do |t|
      t.integer :api_id
      t.references :proposition, null: false, foreign_key: true
      t.datetime :datetime
      t.string :result
      t.text :description

      t.timestamps
    end
    add_index :votings, :api_id
  end
end
