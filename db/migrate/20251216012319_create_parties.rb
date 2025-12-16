class CreateParties < ActiveRecord::Migration[8.1]
  def change
    create_table :parties do |t|
      t.string :name
      t.string :acronym
      t.integer :api_id

      t.timestamps
    end
    add_index :parties, :api_id
  end
end
