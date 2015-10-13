ThinkingSphinx::Index.define :entry, name: :fishrod_entry, with: :active_record do
  indexes body
  has source_id, created_at, state
end
