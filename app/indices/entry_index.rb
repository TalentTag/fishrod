ThinkingSphinx::Index.define :entry, with: :active_record do
  indexes body
  has source_id, created_at
end
