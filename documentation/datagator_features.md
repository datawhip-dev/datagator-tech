## 🐊 DataGator / FSIndex — Full Feature Matrix

> _"Crawl once. Know everything."_

---

### 🔍 Core Functional Capabilities

| Feature | Description |
|--------|-------------|
| ✅ **Recursive Archive Extraction** | Treats archives like virtual filesystems. Handles TAR, ZIP, GZ, 7z, ISO, DMG, ARK, QIC, MDOS, and custom legacy formats. |
| ✅ **Filesystem Sandbox** | Extracts to a local sandbox with full structural fidelity. Maintains links, sparse files, perms, metadata. |
| ✅ **Sparse File Detection** | Uses native OS APIs (e.g. `SEEK_HOLE`, `FSCTL_QUERY_ALLOCATED_RANGES`) to detect and preserve sparse file regions. |
| ✅ **Deduplication Engine** | Chunk-level or file-level de-dupe across nested archive trees, even across containers. Hashes content, not just paths. |
| ✅ **Path-Hash Provenance** | Generates left-associative hash chains of path segments + content to create unique per-file fingerprints. |
| ✅ **Composite File Mapping** | Nested ARK/QIC/MDOS inside TAR inside ISO? No problem. Each layer is composable, traceable, and explorable. |
| ✅ **Multi-format Export** | Repack into modern formats (e.g. ZIP64, TAR, CPIO) or reconstruct legacy images (e.g. .DSK, .QIC, .IMG) for write-back testing. |
| ✅ **Metadata Normalization** | Converts vintage or broken encodings (e.g. DOS high ASCII, Shift-JIS) to safe, modern UTF-8. |
| ✅ **Unicode Truth Normalization** | Canonicalizes filenames and metadata using Unicode NFC/NFD, eliminating duplicate path issues across filesystems. Detects normalization mismatches and preserves raw bytes for forensic accuracy. |
| ✅ **Identity Preservation** | Maintains UID/GID, mode bits, timestamps, extended attributes (ACLs, xattrs, etc). |
| ✅ **Provenance Hashing** | Deterministically computes where a file came from and its hash lineage across archives and paths. |
| ✅ **Disk Image Support** | Can mount, read, extract from raw `.img`, `.iso`, `.dmg`, `.dsk`, and loopback block devices. |
| ✅ **Raw Device Ingestion** | Mounts loop devices into containers (`/dev/raw0`) for snapshot, comparison, or read-only replay. |
| ✅ **Filesystem Event Integration** | On Windows, uses `fs_events`; on macOS, integrates with `FSEvents`; on Linux, supports `inotify` or `fanotify` to detect real-time file changes. |
| ✅ **Left-Associative Hashing** | Enables fast prefix-based identity tracking for content and paths. Used for building tree hashes and sparse-aware integrity indexes. |
| ✅ **Retro Filesystem Emulation** | Can reconstruct virtual filesystems inside MDOS/QIC images with correct geometry and metadata for testing or export. |
| ✅ **Archive Rehydration** | Converts normalized sandbox contents back into legacy formats while preserving metadata and structure. |
| ✅ **Test Filesystem Generation** | Supports generation of fully synthetic FS images with edge cases (holes, links, sparse regions, broken metadata). |
| ✅ **Hot-pluggable Loop Device Mapper** | `raw_device_mapper` helper script to inject raw disk images into containers with loopback + `/dev/rawX` mappings. |

---

### 🧐 Advanced Use Cases / Vertical Kill List

| Vertical Killed | Killer Feature |
|------------------|----------------|
| 🔐 **Forensics** | Immutable, mountable snapshots with path+content provenance and timeline verification. |
| 📟 **eDiscovery** | Composite archive unpacking + deduplication + searchable hashes + legal export format support. |
| 🤓 **Digital Preservation** | MDOS, QIC, ARK format extraction + normalized output = perfect for NARA, museums, academia. |
| 📄 **Legal Chain-of-Custody** | Hash chain per file, with rehydration metadata = verifiable, court-admissible lineage. |
| 👷️‍♂️ **DevOps Artifact Management** | Extracts and deduplicates container images, firmware bundles, vendor packages. |
| 🕸️ **Crawl + Index Systems** | Infogator/Infocobra-style recursive archive crawling across storage, cloud buckets, shared drives. |
| 🧑‍🏫 **Education / CS Research** | Observe low-level formats, filesystem behavior, and disk artifacts in high fidelity. |
| 💾 **Backup + Restore** | De-duplicate smart backups with path-aware fingerprints and sparse hole preservation. |
| 📦 **Container Explainers** | Unpack Docker/OCI layers and reconstruct the original file hierarchy with metadata fidelity. |
| 🛀 **Firmware Reverse Engineering** | Explore raw device dumps from embedded systems, QIC tapes, BIOS/ROM formats. |
| 📝 **Binary Indexing + Threat Intel** | Fingerprint ELF, PE, Mach-O, and recognize variants across nested archives. |
| 📊 **Logistics / Compliance** | Scan nested containers and legacy media for PII, license files, expired certs. |
| 🛍️ **Supply Chain Audits** | Indexes provenance and reuse of packages across vendor-delivered blobs. |

---

### 🛠️ CLI & DevOps Integration

| Feature | Description |
|--------|-------------|
| ✅ **Docker-first Ingestion** | Raw disk files piped into containers using loop devices + `--device=/dev/raw0`. |
| ✅ **Composable Toolchain** | Plug into pipelines (`infogator scan path/`, `infocobra index -r target/`) as a first-class stage. |
| ✅ **Manifest Output** | JSON/YAML representation of structure, hashes, mappings, metadata for full observability. |
| ✅ **Schema for Archives** | Pluggable extractors with declarative format schemas for all composite types. |
| ✅ **Custom Test FS Generator** | Generate full fake filesystems with weird edges (holes, links, garbage metadata) to test integrity. |
| ✅ **Hash Tree Comparison** | Compare two archive structures or container images using tree hash deltas. |
| ✅ **Filesystem Watch Mode** | Watch local FS changes with `inotify`, `FSEvents`, or `fs_events` for reindex or validation triggers. |
| ✅ **FUSE-like Interface** *(planned)* | Mount indexed archives as a virtual filesystem for direct inspection. |
| ✅ **Self-healing Dedupe Cache** *(planned)* | Auto-evicts corrupted chunks and recrawls affected paths using deterministic provenance hash. |

---

### 🚀 Future Expansion Vectors

| Idea | Use |
|------|-----|
| 🌐 **Web-UI Explorer** | Point-and-click archive explorer with visual hash overlays, tree diffs, path provenance. |
| 🧠 **AI Summarizer** | LLM-based summarization of archive contents, differences, suspicious paths. |
| 📚 **Plugin SDK** | Let users add readers for weird formats (`infogator add-parser my_format.py`). |
| 🐐 **Kraken Mode** | Ingest all archives, indexes, and sparse-detected images across an entire filesystem hierarchy. |
| 📊 **PostgreSQL/SQLite Index Backend** | Persistent cross-session crawling index with diff/search/query history. |
| ⌛ **Time-Machine Mode** | Archive snapshots with diffable history view and lineage tracking. |
| 🔢 **CLI Profile Mode** | Show memory usage, crawl time, dedup hits, hole regions per archive. |
| 🛠️ **Syscall Tracing for Files Used** | Use `strace`/`dtruss` to trace files actually accessed during container or VM runs. |

---



