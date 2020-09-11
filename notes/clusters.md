# Clusters and Shards

## Cluster Health

```
GET /_cluster/health
```

- `status: green`: all primary and replica shards are active.
- `status: yellow`: all primary shards are active, but not all replica shards are.
- `status: red`: not all primary shards are active.

Data is distributed around a cluster via shards. However, applications don't talk directly to shards. Instead, they talk to an index.

### Primary vs. replica shard

- Each document in an index belongs to a single primary shard.
- A replica shard is a copy of a primary shard. These are used to provide redundant copies of data to protect against hardware failure.
- Number of primary shards in an index is fixed at creation, but replica shards can be changed at any time.

Any newly index document is stored first on a primary shard, then copied to associated replica shards.

A note on throughput:

Generally, the more copies of data that you have, the more search throughput you can handle. Although, note that this requires expanding the number of nodes as well, as each shard will only have access to a fraction of its node's resources.
