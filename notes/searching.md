# Searching

Elasticsearch provides query-string searching and a query DSL.

- Documents returned will include `_score` specifying how well the document matches the query.
- Different query types provide different functionality. Some examples: `match`, `filtered`, `match_phrase`.
- Highlights can be specified to return snippets of text with `<em>` tags demonstrating matches.
- Aggregations (`aggs`) allow users to generate analytics over searched data.

## Paging in distributed systems

- Each shard generates its own sorted results that need to be sorted centrally.
- e.g. given five primary shards, when requesting results 1-10 each shard provides its own top 10 results, requiring the requesting node to sort through 50 results.

## Across types and indices

Searching works across indices, types, and clusters:

- `/_search`: all types in all indices.
- `/megacorp/_search`: all types in the `megacorp` index.
- `/megacorp/employee/_search`: `employee` types in the `megacorp` index.
- `/m*/_search`: all types in indices beginning with `m`.

Elasticsearch will forward a search within a single index to a primary or replica of every shard in that index. That means that searching one index with five primary shards is equivalent to searching five indices with one primary shard each.

## Examples

### Query-string (lite):

```
GET /megacorp/employee/_search?q=last_name:Smith
```

### Standard DSL:

Equivalent example:

```
GET /megacorp/employee/_search
{
    "query" : {
        "match" : {
            "last_name" : "Smith"
        }
    }
}
```

A slightly more complex query:

```
GET /megacorp/employee/_search
{
    "query" : {
        "filtered" : {
            "filter" : {
                "range" : {
                    "age" : { "gt" : 30 }
                }
            },
            "query" : {
                "match" : {
                    "last_name" : "smith"
                }
            }
        }
    }
}
```

And finally a full-text search:

```
GET /megacorp/employee/_search
{
    "query" : {
        "match" : {
            "about" : "rock climbing"
        }
    }
}
```
