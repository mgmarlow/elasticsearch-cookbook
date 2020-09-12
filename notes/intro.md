# Intro

This cookbook serves as a general guide to understanding and working with Elasticsearch. Included are [notes](../) on important topics and an [example ruby application](../examples/) to enable easy experimentation.

To run the ruby examples, refer to the [README](../README.md).

## What is Elasticsearch?

Open source search engine built on top of Apache Lucene. Provides a RESTful API that hides a lot of the complexity of Lucene.

- Distributed by nature.
- A document store for JSON documents.
- All data in every field is indexed by default.

Example HTTP query:

```sh
curl -XGET 'localhost:9200/_count?pretty' -d '
{
    "query": {
        "match_all": {}
    }
}'
```

## Document-oriented

Elasticsearch stores entire objects, referred to as documents.

- The contents of each document are indexed to make them searchable
- Documents belong to types that live inside an index

A **cluster** can contain multiple **indices** which in turn contain multiple **types**. Types hold multiple **documents** that each have many **fields**.

## Searching

Elasticsearch provides query-string searching and a query DSL.

### Query-string:

```
GET /megacorp/employee/_search?q=last_name:Smith
```

### DSL (GET request w/ JSON request body):

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

- Documents returned will include `_score` specifying how well the document matches the query.
- Different query types provide different functionality. Some examples: `match`, `filtered`, `match_phrase`.
- Highlights can be specified to return snippets of text with `<em>` tags demonstrating matches.
- Aggregations (`aggs`) allow users to generate analytics over searched data.
