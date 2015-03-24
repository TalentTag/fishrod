class CreateEntries < ActiveRecord::Migration

  def change
    create_table :entries do |t|
      t.text :body, null: false
      t.string :url, null: false
      t.string :source, null: false
      t.json :author
      t.json :raw_data
      t.timestamp :created_at
      t.timestamp :fetched_at
    end
  end

end
