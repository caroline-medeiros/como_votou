class CreatePropositions < ActiveRecord::Migration[8.1]
  def change
    create_table :propositions do |t|
      t.integer :api_id
      t.string :title
      t.text :description
      t.string :status
      t.integer :year

      t.timestamps
    end
    add_index :propositions, :api_id
  end
end
