# Analysis

Recall that **mapping** refers to a document's schema definition.

The most important mapping distinction to recognize in Elasticsearch is the difference between exact values and full text:

**Exact values**: dates, IDs, or fields that we want to compare via exact values.

**Full text**: textual (unstructured) data that is compared via a relevance calculation. These fields need to be analyzed to figure out what is relevant.

## When is analyzing applied?

During indexing, full text fields are analyzed into terms to create an inverted index. During searches, the search query is analyzed via the same process to ensure the search terms match the index terms.

Observe the effect of an analyzer by querying against the `_analyze` API:

```
GET /_analyze?analyzer=standard
Text to analyze
```

## Inverted Index

1. A list of all unique words that appear in any document.
2. A list of all documents in which a word appears.

Analysis defines the process that (a) tokenizes text into individual terms for the inverted index and (b) normalizing these terms into a standardized form. This process is carried out by **analyzers**.

Elasticsearch supports both prebuilt and custom analyzers.

## Prebuilt analyzers

**Standard analyzer**: Elasticsearch's default. Splits text on [word boundaries](http://www.unicode.org/reports/tr29/), removes most punctuation, lowercases terms.

**Simple analyzer**: splits text on anything that isn't a letter and lowercases.

**Whitespace analyzer**: splits text on whitespace, doesn't lowercase.

**Language analyzers**: take into account peculiarities of specific languages. For example, `english` will remove common stopwords (and, the) and also stems some words.

## Mapping

Defines the fields within a type, the datatype of each field, and how the fields should be handled by Elasticsearch. Elasticsearch will attempt to provide default mappings for new fields, if a mapping is not specified.

- Specified when the index is first created
- New fields added via `PUT /_mapping`
- **Cannot be changed for existing fields**


Example mapping for a single `tag` field:

```
{
  "tag": {
    "type": "string", # Defaults to full text handling (analyzed)
    "index": "not_analyzed", # analyzed, not_analyzed, no
    "analyzer": "english" # Defaults to standard
  }
}
```

`index`:
- `analyzed`: handle as full text
- `not_analyzed`: handle as exact value
- `no`: don't index this field at all

### Complex mapping types

Multi-value fields (arrays) are supported, with the following caveat:
- Empty values will not be indexed (`[]`, `null`, `[null]`)

Multi-level fields (objects) are also supported.
- Note: Lucene doesn't understand inner objects, so Elasticsearch converts the document into a flat structure.
- Nested arrays will lose their correlation.

`object` mapping:

```
{
  "followers": [
    { "age": 35, "name": "Mary White"},
    { "age": 26, "name": "Alex Jones"},
    { "age": 19, "name": "Lisa Smith"}
  ]
}

Becomes

{
  "followers.age":    [19, 26, 35],
  "followers.name":   [alex, jones, lisa, smith, mary, white]
}
```

We can use the `nested` mapping to get around this, mapping each nested object as a hidden, separate document.
- This enables Elasticsearch to maintain the relationship between nested fields.
- Search requests return the entire document, not just the nested object.
- Nested objects are queried differently since they are indexed as separate documents.
