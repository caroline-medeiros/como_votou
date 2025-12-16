class CreateDeputies < ActiveRecord::Migration[8.1]
  def change
    create_table :deputies do |t|
      t.string :name
      t.string :photo_url
      t.integer :api_id
      t.references :party, null: false, foreign_key: true
      t.string :state
      t.string :email

      t.timestamps
    end
    add_index :deputies, :api_id
  end
end
