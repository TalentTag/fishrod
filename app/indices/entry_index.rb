ThinkingSphinx::Index.define :entry, name: :fishrod_entry, with: :active_record do
  indexes body
  has id, as: :entry_id
  has source_id, fetched_at, state
end
