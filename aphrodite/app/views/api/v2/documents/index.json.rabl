collection @documents
attributes :id, :title, :created_at, :percentage

node :counters do  |document|
  {
    people: document.context_cache.fetch('people', []).count,
    organizations: document.context_cache.fetch('organizations', []).count,
    places: document.context_cache.fetch('places', []).count,
    dates: document.context_cache.fetch('dates', []).count
  }
end

node :persisted do |document|
  document.persisted?
end

node :error_messages do |document|
  document.errors.messages
end