# Intro

This cookbook serves as a general guide to understanding and working with Elasticsearch. Included are [notes](../) on important topics and an [example ruby application](../examples/) to enable easy experimentation.

To run the ruby examples, refer to the [README](../README.md).

## What is Elasticsearch?

Open source search engine and distributed document store built on top of Apache Lucene. Provides a RESTful API that hides a lot of the complexity of Lucene.

- Distributed by nature.
- A document store for JSON documents.
- Every field in a document is indexed and can be queried.

Example search:

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

## Document-oriented

Elasticsearch stores entire objects, referred to as documents.

- The contents of each document are indexed to make them searchable
- Documents belong to types that live inside an index

A **cluster** can contain multiple **indices** which in turn contain multiple **types**. Types hold multiple **documents** that each have many **fields**.
