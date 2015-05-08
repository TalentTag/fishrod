class EntryState < ActiveRecord::Migration

  def change
    add_column :entries, :state, :integer, null: false, default: 0
  end

end
