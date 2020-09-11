module Megacorp
  class SearchService
    include SearchClient
    include Elasticsearch::DSL

    def by_name(name)
      definition = search do
        query do
          match last_name: name
        end
      end

      search_client.search(body: definition.to_hash)
    end
  end
end
