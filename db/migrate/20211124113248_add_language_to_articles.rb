class AddLanguageToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :language, :string
  end
end
