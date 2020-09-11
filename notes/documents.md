# What is a document anyway?

A document is an object that is serialized into JSON and stored in Elasticsearch under a unique ID.

### Document Metadata

- `_index`: where the document lives.
- `_type`: what class of object the document is.
- `_id`: unique ID for the document.

Note: every type has an associated schema definition (called a **mapping**) that defines the document structure for that type.
