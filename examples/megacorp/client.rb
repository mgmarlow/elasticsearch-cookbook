module Megacorp
  module SearchClient
    def search_client
      @client ||= Elasticsearch::Client.new(url: 'http://localhost:9200', log: true)
    end
  end
end
