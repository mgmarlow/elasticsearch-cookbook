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

## Distributed Document Store

- Indexed documents are stored on a single primary shard:
  ```
  shard = hash(document._id) % num_primary_shards
  ```
- The number of primary shards cannot be changed after the index is created because it would invalidate the shard assignment above.
- Every node knows the location of every document in the cluster so it can forward requests.
  - It's good practice to cycle requesting nodes to distribute load.
- `replication` strategies:
  - `sync`: primary shard waits for successful responses from replica shards before returning.
  - `async`: returns success as soon as the request is executed on the primary shard.
- `consistency`:
  - `default`: primary shard requires the majority (quorum) of shard copies to be available before attempting a write.
  - `one`: just the primary shard.
  - `all`: the primary and all replicas.

## Performing CRUD actions across nodes

`create`/`index`/`delete` steps:

1. Client requests against requesting node
2. Requesting node locates the document using its `_id` and forwards the request to the shard where the primary copy is allocated.
3. The node containing the document's primary shard executes the request and forwards a successful result to replica shards.

`read` steps:

1. Client requests against requesting node.
2. Requesting node determines which shard the document belongs to. Depending on the round-robin rotation, it will forward the request or resolve it directly depending on which nodes contain copies of the document.
3. The document is returned to the requesting node and then to the client.

`mget` steps:

1. Client requests against requesting node.
2. Requesting node builds mutli-get request per shard and forwards them in parallel to the nodes hosting the required primary/replica shard.
3. Once all replicas have been received, the requesting node builds the response and returns it to the client.

`bulk` steps:

Similar to `mget` steps, with the difference that each action is executed synchronously in order, rather than in parallel.
