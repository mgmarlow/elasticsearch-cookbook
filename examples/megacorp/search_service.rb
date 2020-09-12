module Megacorp
  class SearchService
    include SearchClient
    include Elasticsearch::DSL

    def by_last_name(name)
      definition = search do
        query do
          match last_name: name
        end
      end

      execute_search(definition.to_hash)
    end

    def execute_search(body)
      search_client.search(body: body)
    end
  end
end
