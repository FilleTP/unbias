class AddSentimentToComparison < ActiveRecord::Migration[6.0]
  def change
    add_column :comparisons, :sentiment_one, :string
    add_column :comparisons, :sentiment_two, :string
  end
end
