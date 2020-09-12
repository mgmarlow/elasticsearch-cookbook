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

# Run search queries
Megacorp.search_service.by_name('smith')

=> {"took"=>2,
 "timed_out"=>false,
 "_shards"=>{"total"=>1, "successful"=>1, "skipped"=>0, "failed"=>0},
 "hits"=>
  {"total"=>{"value"=>2, "relation"=>"eq"},
   "max_score"=>0.4700036,
   "hits"=>
    [{"_index"=>"megacorp",
      "_type"=>"employee",
      "_id"=>"0",
      "_score"=>0.4700036,
      "_source"=>{"first_name"=>"John", "last_name"=>"Smith", "age"=>25, "about"=>"I love to go rock climbing", "interests"=>["sports", "music"]}},
     {"_index"=>"megacorp",
      "_type"=>"employee",
      "_id"=>"1",
      "_score"=>0.4700036,
      "_source"=>{"first_name"=>"Jane", "last_name"=>"Smith", "age"=>32, "about"=>"I like to collect rock albums", "interests"=>["music"]}}]}}
```

## References

- [Elasticsearch: The Definitive Guide](https://learning.oreilly.com/library/view/elasticsearch-the-definitive/9781449358532/)
- [`elasticsearch-ruby`](https://github.com/elastic/elasticsearch-ruby)
