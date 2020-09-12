# Elasticsearch Cookbook

A collection of Elasticsearch notes and examples.

## Table of Contents

- [Intro](./notes/intro.md)
- [Clusters](./notes/clusters.md)
- [Documents](./notes/documents.md)
- [Glossary](./notes/glossary.md)

## Installation

Prerequisites:

- [Elasticsearch](https://www.elastic.co/downloads/elasticsearch)
- [Ruby](https://www.ruby-lang.org/en/downloads/)
- [Bundler](https://bundler.io/)

```
bundle install
```

## Running the Examples

Run Elasticsearch (defaults to `localhost:9200`):

```
elasticsearch.bat
```

Run the console:

```
./bin/console
```

Now you can interact with the example applications:

```rb
# Set up initial data
Megacorp.seed_employees

# Run pre-built search queries
Megacorp.search_service.by_last_name('smith')

# Or custom queries:
Megacorp.search({
  query: {
    match: {
      last_name: 'smith'
    }
  }
})
```

## References

- [Elasticsearch: The Definitive Guide](https://learning.oreilly.com/library/view/elasticsearch-the-definitive/9781449358532/)
- [`elasticsearch-ruby`](https://github.com/elastic/elasticsearch-ruby)
