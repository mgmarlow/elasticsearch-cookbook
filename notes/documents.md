# What is a document anyway?

A document is an object that is serialized into JSON and stored in Elasticsearch under a unique ID.

### Document metadata

- `_index`: where the document lives.
- `_type`: what class of object the document is.
- `_id`: unique ID for the document.
- `_source`: the original JSON document that was sent to Elasticsearch.

Note: every type has an associated schema definition (called a **mapping**) that defines the document structure for that type.

## Document CRUD

- Every document has a version number that is automatically incremented when a change is made to that document.
- Elasticsearch really seems to behave like a normal document store.
- Versioning on a per-document basis is built-in.

### Retrieving a single document
- 200 if exists, 404 if doesn't.

```
GET /website/blog/123?pretty
```

Maps to:

```
GET /{index}/{type}/{id}
```

### Retrieving multiple documents

Can retrieve multiple documents of many different types through the `MGET` API.

The API can also be further honed to certain indices and types, e.g. `GET /website/blog/_mget`. When this syntax is used, you won't need to specify `_index` and `_type` in the request.

Documents that aren't found will return `found: false`, but will not affect the retrieval of any other documents specified in the request. `MGET` will always return a 200 in these situations.

```
GET /_mget
{
    "docs": [
        { "_index": "website", "_type": "blog", "_id": 2 },
        ...
    ]
}
```

Similar to `MGET`, there's also a bulk API for performing many `create`, `index`, `update`, or `delete` requests in a single step.

### Updating documents

When documents are updated the old version isn't deleted immediately. It is cleaned up by Elasticsearch at a later point in type. You will not be able to access old versions.

Updating will always (a) delete the old document and (b) index a new document. No documents are ever edited in-place.

Partial updates can be performed with the `_update` keyword:

```
POST /website/blog/1/_update
```

Full updates are performed via `PUT`:

```
PUT /website/blog/1/
```

Scripts can also be used to change the document content based on its current values:

```
POST /website/blog/1/_update
{
    "script": "ctx._source.views+=1"
}
```

### Conflicts

- Last document indexed wins.
- Any changes that happen in-progress are **lost** when they are overridden by the last document indexed.
- Referred to as "Optimistic concurrency control". Conflicts are assumed to be unlikely.

**The version number of a document can be used to avoid losing data in the case of simultaneous updates**:

The following request will only succeed if the current `_version` of the document in the index is `1`. A failed update results in a `409 Conflict`.

```
PUT /website/blog/1?version=1
```

This technique can be used to inform users that their requested change has been blocked due to a version mismatch.

## Data synchronization with external systems

**Setup**: another database is the primary data store and Elasticsearch simply makes the data searchable.

- Specify `version_type=external` to enable using a timestamp or similar as the document version number.
- Elasticsearch checks that the current version number is less than the provided version number. Note that the datatype is a positive `long`.

Example:

```
PUT /website/blog/2?version=5&version_type=external
=> { ..., "_version": 5 }

PUT /website/blog/2?version=10&version_type=external
=> { ..., "_version": 10 }
```
