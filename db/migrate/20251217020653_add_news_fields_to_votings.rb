class AddNewsFieldsToVotings < ActiveRecord::Migration[8.1]
  def change
    add_column :votings, :news_title, :string
    add_column :votings, :summary, :text
  end
end
