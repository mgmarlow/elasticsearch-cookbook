# Analysis

Recall that **mapping** refers to a document's schema definition.

The most important mapping distinction to recognize in Elasticsearch is the difference between exact values and full text:

**Exact values**: dates, IDs, or fields that we want to compare via exact values.

**Full text**: textual (unstructured) data that is compared via a relevance calculation. These fields need to be analyzed to figure out what is relevant.

## When is analyzing applied?

During indexing, full text fields are analyzed into terms to create an inverted index. During searches, the search query is analyzed via the same process to ensure the search terms match the index terms.

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
