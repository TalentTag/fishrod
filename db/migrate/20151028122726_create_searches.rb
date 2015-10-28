class CreateSearches < ActiveRecord::Migration

  def change
    create_table :searches do |t|
      t.string :name
      t.text :query, null: false
      t.text :context
      t.text :stopwords
    end
  end

end
