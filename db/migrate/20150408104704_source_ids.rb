class SourceIds < ActiveRecord::Migration

  def up
    remove_column :entries, :source
    add_column :entries, :source_id, :integer, null: false
  end

  def down
    remove_column :entries, :source_id
    add_column :entries, :source, :string, null: false
  end

end
