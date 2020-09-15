# Distributed Document Store

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
