require 'elasticsearch'

client = Elasticsearch::Client.new(url: 'http://localhost:9200', log: true)

client.transport.reload_connections!

client.cluster.health

client.search(q: 'test')

