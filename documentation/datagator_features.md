## 🐊 DataGator / FSIndex — Full Feature Matrix

> _"Crawl once. Know everything."_

---

### 🎯 Who Is DataGator Core For?

**DataGator Core** is built for the **technically capable power user** — not the average consumer.

Typical users include:

- 🛠 **Home lab architects** managing multi-device setups, ZFS pools, or Pi clusters
- 🧑‍💼 **Small business IT** with mixed Windows/Linux/macOS environments
- 💾 **NAS and backup power users** who care about filesystem integrity
- 🧪 **Researchers and developers** scanning project archives or legacy datasets
- 🔍 **Forensic tinkerers** resurrecting 20-year-old ZIPs or floppies
- 🧠 **Data restoration pros** who want transparency, not magic

DataGator Core assumes:

- You're comfortable with Docker or Podman
- You understand file permissions and bind mounts
- You're fine using `sudo` *when needed* for full scan fidelity

If you're looking for **a point-and-click button** — this isn’t it. But if you want **audit-grade scans, clean design, and serious control** — welcome aboard.

---

### 🎯 Vertical Kill Capabilities (Targets & Replacements)

| Targeted Vertical | What's Dead | Datagator Replacement |
|--------------------|-------------|------------------------|
| 🛠️ Dev Environments | Declarative chaos (Dockerfiles, Ansible, Nix) | Rehydrated hash-based working sets (`datagator restore <manifest>`) |
| 📥 Package Managers | Dependency hell (`apt`, `yum`, `brew`) | Manifest-driven install via signed, deduped segments |
| 📦 Enterprise Storage | $$$ per GB, siloed data | Content-indexed global dedupe with overlay sync |
| 🔑 Secure Vaults | Opaque secrets (Vault, AWS KMS) | Snapshot-attested, encrypted segments with signature trail |
| 🧠 ML Registries | No model lineage (MLFlow, HF Hub) | Corpus → Model hash chain + legal reproducibility |
| 🧾 SBOM Generators | Post-facto guesswork | Timestamped, signed manifests at the source (no scan needed) |
| 🧑‍⚖️ Regulatory Engines | Illusory audit logs | Immutable path + ACL + content lineage proofs |
| 🛜 IoT Platforms | Bloatware + telemetry (Home Assistant, Alexa) | Popcorn kernels + sync-only hash configs, no vendor clouds |
| 💡 BI/Analytics | Warehouse tax | Time-travel queries over deduped segment snapshots |
| 🕵️ Digital Evidence | Fragile extractions (Cellebrite, XRY) | Immutable, forensically admissible hash+path snapshot chains |

---

### 🔍 Core Functional Capabilities

| Feature | Description |
|--------|-------------|
| ✅ **Historical Distro Package Walker** | Recursively decomposes `.src.rpm`, `.deb-src`, and legacy distro packages, reconstructing full build graphs from source, patch, spec, and git commits. Maps binaries to upstream commits and reconstructs provenance for every file from kernel to libc. |
| ✅ **Recursive Archive Extraction** | Treats archives like virtual filesystems. Handles TAR, ZIP, GZ, 7z, ISO, DMG, ARK, QIC, MDOS, and custom legacy formats. |
| ✅ **Filesystem Sandbox** | Extracts to a local sandbox with full structural fidelity. Maintains links, sparse files, perms, metadata. |
| ✅ **Sparse File Detection** | Uses native OS APIs (e.g. `SEEK_HOLE`, `FSCTL_QUERY_ALLOCATED_RANGES`, APFS dataless ranges) to detect and preserve sparse file regions. Includes logic for identifying orphaned blocks from deleted large files. |
| ✅ **Deduplication Engine** | Chunk-level or file-level de-dupe across nested archive trees, even across containers. Hashes content, not just paths. Preserves inode link count and supports hardlink-aware tracking. |
| ✅ **Path-Hash Provenance** | Generates left-associative hash chains of path segments + content to create unique per-file fingerprints. |
| ✅ **Composite File Mapping** | Nested ARK/QIC/MDOS inside TAR inside ISO? No problem. Each layer is composable, traceable, and explorable as a virtual filesystem. |
| ✅ **Multi-format Export** | Repack into modern formats (e.g. ZIP64, TAR, CPIO) or reconstruct legacy images (e.g. .DSK, .QIC, .IMG) for write-back testing. |
| ✅ **Metadata Normalization** | Converts vintage or broken encodings (e.g. DOS high ASCII, Shift-JIS) to safe, modern UTF-8. |
| ✅ **Unicode Truth Normalization** | Canonicalizes filenames and metadata using Unicode NFC/NFD, eliminating duplicate path issues across filesystems. Detects normalization mismatches and preserves raw bytes for forensic accuracy. |
| ✅ **Identity Preservation** | Maintains UID/GID, mode bits, timestamps, extended attributes (ACLs, xattrs, etc). Normalizes across NTFS/ext4/APFS. |
| ✅ **ACL Translation and Comparison** | Compares NTFS, ext4, APFS, and NFSv4 ACLs. Provides SID ↔ UID/GID mapping and cross-platform permission diffs. |
| ✅ **Provenance Hashing** | Deterministically computes where a file came from and its hash lineage across archives and paths. Supports archive overlay comparison. |
| ✅ **Disk Image Support** | Can mount, read, extract from raw `.img`, `.iso`, `.dmg`, `.dsk`, and loopback block devices. Includes `.sparsebundle` ingestion with band-wise hash tracking, virtual block overlay, and mountless snapshot scanning. |
| ✅ **Raw Device Ingestion** | Mounts loop devices into containers (`/dev/raw0`) for snapshot, comparison, or read-only replay. Includes `raw_device_mapper` helper. |
| ✅ **Filesystem Event Integration** | On Windows, uses `fs_events`; on macOS, integrates with `FSEvents`; on Linux, supports `inotify` or `fanotify` to detect real-time file changes. Supports watch mode for live crawls. |
| ✅ **Left-Associative Hashing** | Enables fast prefix-based identity tracking for content and paths. Used for building tree hashes and sparse-aware integrity indexes. |
| ✅ **Retro Filesystem Emulation** | Can reconstruct virtual filesystems inside MDOS/QIC images with correct geometry and metadata for testing or export. |
| ✅ **Archive Rehydration** | Converts normalized sandbox contents back into legacy formats while preserving metadata and structure. |
| ✅ **Test Filesystem Generation** | Supports generation of fully synthetic FS images with edge cases (holes, links, sparse regions, broken metadata). |
| ✅ **Overlay Matching and Fingerprinting** | Recognizes previously seen container image overlays or extracted package sets for diffing, reuse, and cache-awareness. |
| ✅ **Sealed Forensic Image Ingestion** | Supports `.E01`, `.AFF`, `.dd`, and raw sector images as read-only composite archives. Preserves cryptographic signatures, appends metadata without altering source. Mounts in walk-only mode with sector-level offset mapping and lineage logging. |
| ✅ **Time Machine Snapshot Crawler** | Detects and indexes Time Machine backup trees (`Backups.backupdb/`) with support for hardlink-aware deduping across snapshots. Supports both modern (APFS) and legacy (HFS+ inside `.sparsebundle`) Time Machine formats. Captures deltas, timeline metadata, and xattr history per snapshot. Includes `--timemachine-mode` CLI flag. |

---

### 🔍 Core Functional Capabilities

| Feature | Description |
|--------|-------------|
| ✅ **Historical Distro Package Walker** | Recursively decomposes `.src.rpm`, `.deb-src`, and legacy distro packages, reconstructing full build graphs from source, patch, spec, and git commits. Maps binaries to upstream commits and reconstructs provenance for every file from kernel to libc. |
| ✅ **Recursive Archive Extraction** | Treats archives like virtual filesystems. Handles TAR, ZIP, GZ, 7z, ISO, DMG, ARK, QIC, MDOS, and custom legacy formats. |
| ✅ **Filesystem Sandbox** | Extracts to a local sandbox with full structural fidelity. Maintains links, sparse files, perms, metadata. |
| ✅ **Sparse File Detection** | Uses native OS APIs (e.g. `SEEK_HOLE`, `FSCTL_QUERY_ALLOCATED_RANGES`, APFS dataless ranges) to detect and preserve sparse file regions. Includes logic for identifying orphaned blocks from deleted large files. |
| ✅ **Deduplication Engine** | Chunk-level or file-level de-dupe across nested archive trees, even across containers. Hashes content, not just paths. Preserves inode link count and supports hardlink-aware tracking. |
| ✅ **Path-Hash Provenance** | Generates left-associative hash chains of path segments + content to create unique per-file fingerprints. |
| ✅ **Composite File Mapping** | Nested ARK/QIC/MDOS inside TAR inside ISO? No problem. Each layer is composable, traceable, and explorable as a virtual filesystem. |
| ✅ **Multi-format Export** | Repack into modern formats (e.g. ZIP64, TAR, CPIO) or reconstruct legacy images (e.g. .DSK, .QIC, .IMG) for write-back testing. |
| ✅ **Metadata Normalization** | Converts vintage or broken encodings (e.g. DOS high ASCII, Shift-JIS) to safe, modern UTF-8. |
| ✅ **Unicode Truth Normalization** | Canonicalizes filenames and metadata using Unicode NFC/NFD, eliminating duplicate path issues across filesystems. Detects normalization mismatches and preserves raw bytes for forensic accuracy. |
| ✅ **Identity Preservation** | Maintains UID/GID, mode bits, timestamps, extended attributes (ACLs, xattrs, etc). Normalizes across NTFS/ext4/APFS. |
| ✅ **ACL Translation and Comparison** | Compares NTFS, ext4, APFS, and NFSv4 ACLs. Provides SID ↔ UID/GID mapping and cross-platform permission diffs. |
| ✅ **Provenance Hashing** | Deterministically computes where a file came from and its hash lineage across archives and paths. Supports archive overlay comparison. |
| ✅ **Disk Image Support** | Can mount, read, extract from raw `.img`, `.iso`, `.dmg`, `.dsk`, and loopback block devices. Includes `.sparsebundle` ingestion with band-wise hash tracking, virtual block overlay, and mountless snapshot scanning. |
| ✅ **Raw Device Ingestion** | Mounts loop devices into containers (`/dev/raw0`) for snapshot, comparison, or read-only replay. Includes `raw_device_mapper` helper. |
| ✅ **Filesystem Event Integration** | On Windows, uses `fs_events`; on macOS, integrates with `FSEvents`; on Linux, supports `inotify` or `fanotify` to detect real-time file changes. Supports watch mode for live crawls. |
| ✅ **Left-Associative Hashing** | Enables fast prefix-based identity tracking for content and paths. Used for building tree hashes and sparse-aware integrity indexes. |
| ✅ **Retro Filesystem Emulation** | Can reconstruct virtual filesystems inside MDOS/QIC images with correct geometry and metadata for testing or export. |
| ✅ **Archive Rehydration** | Converts normalized sandbox contents back into legacy formats while preserving metadata and structure. |
| ✅ **Test Filesystem Generation** | Supports generation of fully synthetic FS images with edge cases (holes, links, sparse regions, broken metadata). |
| ✅ **Overlay Matching and Fingerprinting** | Recognizes previously seen container image overlays or extracted package sets for diffing, reuse, and cache-awareness. |
| ✅ **Sealed Forensic Image Ingestion** | Supports `.E01`, `.AFF`, `.dd`, and raw sector images as read-only composite archives. Preserves cryptographic signatures, appends metadata without altering source. Mounts in walk-only mode with sector-level offset mapping and lineage logging. |
| ✅ **Time Machine Snapshot Crawler** | Detects and indexes Time Machine backup trees (`Backups.backupdb/`) with support for hardlink-aware deduping across snapshots. Supports both modern (APFS) and legacy (HFS+ inside `.sparsebundle`) Time Machine formats. Captures deltas, timeline metadata, and xattr history per snapshot. Includes `--timemachine-mode` CLI flag. |

---

### 🧠 Advanced Use Cases / Vertical Kill List

| Vertical Killed | Killer Feature |
|------------------|----------------|
| 🔐 **Forensics** | Immutable, mountable snapshots with path+content provenance and timeline verification. Tracks orphaned blocks, sealed image hashes, Unicode truth, and canonical path states. Supports walk-only sealed images and `.sparsebundle` integrity. |
| 📏 **eDiscovery** | Composite archive unpacking + deduplication + searchable hashes + legal export format support. Full Unicode normalization and ACL traceability. |
| 🤓 **Digital Preservation** | MDOS, QIC, ARK format extraction + normalized output = perfect for NARA, museums, academia. Supports rehydrated legacy formats. |
| 📄 **Legal Chain-of-Custody** | Hash chain per file, with rehydration metadata = verifiable, court-admissible lineage. Unicode truth and hardlink evidence retained. Preserves sealed forensic image signatures. |
| 👷️‍♂️ **DevOps Artifact Management** | Extracts and deduplicates container images, firmware bundles, vendor packages. Matches overlays and reuses base layers. |
| 🕸️ **Crawl + Index Systems** | Infogator/Infocobra-style recursive archive crawling across storage, cloud buckets, shared drives. Separate CLI personalities. |
| 🧑‍🏫 **Education / CS Research** | Observe low-level formats, filesystem behavior, and disk artifacts in high fidelity. Built-in test FS generator. |
| 📀 **Backup + Restore** | De-duplicate smart backups with path-aware fingerprints and sparse hole preservation. Detects zombie data and hardlink-only file overlays in Time Machine. Traverses `.sparsebundle`-based Time Machine archives and compares per-snapshot state. Full support for `--timemachine-mode` diff view. |
| 📦 **Container Explainers** | Unpack Docker/OCI layers and reconstruct the original file hierarchy with metadata fidelity. Matches known overlay trees. |
| 🛀 **Firmware Reverse Engineering** | Explore raw device dumps from embedded systems, QIC tapes, BIOS/ROM formats. Fingerprint by section. |
| 📝 **Binary Indexing + Threat Intel** | Fingerprint ELF, PE, Mach-O, and recognize variants across nested archives. Detects reused loaders and cryptostubs. |
| 📊 **Logistics / Compliance** | Scan nested containers and legacy media for PII, license files, expired certs. Supports ACL-based access validation. |
| 🛕️ **Supply Chain Audits** | Indexes provenance and reuse of packages across vendor-delivered blobs. Matches overlay fingerprints across time. |
| 🌡️ **Entropy Heat Mapping** | Visual signature of file structure and risk zones. 🔥 Red-hot entropy zones reveal compressed, encrypted, or obfuscated blocks. ❄️ Cool blue for static, predictable data. Useful for firmware audits, stego detection, fake config traps, and binary implants in backdoor-laced images. |

---

### 🛠️ CLI & DevOps Integration

| Feature | Description |
|--------|-------------|
| ✅ **SBOM & QR Verification** | Scan a QR code or validate against SBOMs. Auto-downloads, crawls, and verifies firmware, ISOs, containers, and GitHub artifacts. Flags ghost files and mismatched provenance. |
| ✅ **Software Firewall Mode** | Rewrites or rebuilds untrusted vendor blobs from clean verified sources. Strips telemetry, reapplies SBOMs, and signs safe variants. |
| ✅ **Docker-first Ingestion** | Raw disk files piped into containers using loop devices + `--device=/dev/raw0`. |
| ✅ **Composable Toolchain** | Plug into pipelines (`infogator scan path/`, `infocobra index -r target/`) as a first-class stage. |
| ✅ **Manifest Output** | JSON/YAML representation of structure, hashes, mappings, metadata for full observability. |
| ✅ **Schema for Archives** | Pluggable extractors with declarative format schemas for all composite types. |
| ✅ **Custom Test FS Generator** | Generate full fake filesystems with weird edges (holes, links, garbage metadata) to test integrity. |
| ✅ **Hash Tree Comparison** | Compare two archive structures or container images using tree hash deltas. Supports overlay match detection. |
| ✅ **Filesystem Watch Mode** | Watch local FS changes with `inotify`, `FSEvents`, or `fs_events` for reindex or validation triggers. |
| ✅ **FUSE-like Interface** *(planned)* | Mount indexed archives as a virtual filesystem for direct inspection. |
| ✅ **Self-healing Dedupe Cache** *(planned)* | Auto-evicts corrupted chunks and recrawls affected paths using deterministic provenance hash. |
| ✅ **`--timemachine-mode` Flag** | Enables delta snapshot crawling, inode tracking, and version graph output for APFS/HFS+ Time Machine backups. |
| ✅ **`--heatmap` Flag** | Enables entropy visualization per file or archive. Outputs visual heatmap in ASCII, SVG, or web tile view. Alerts on high-entropy blobs in low-risk zones. Supports manifest annotations and forensic tagging. |

---

### 🚀 Future Expansion Vectors

| Idea | Use |
|------|-----|
| 🌐 **Web-UI Explorer** | Point-and-click archive explorer with visual hash overlays, tree diffs, path provenance. |
| 🧠 **AI Summarizer** | LLM-based summarization of archive contents, differences, suspicious paths. |
| 📚 **Plugin SDK** | Let users add readers for weird formats (`infogator add-parser my_format.py`). |
| 🐐 **Kraken Mode** | Ingest all archives, indexes, and sparse-detected images across an entire filesystem hierarchy. |
| 📊 **PostgreSQL/SQLite Index Backend** | Persistent cross-session crawling index with diff/search/query history. |
| ⌛ **Time-Machine Mode** | Archive snapshots with diffable history view and lineage tracking. Tied to `--timemachine-mode` CLI logic. |
| 📉 **CLI Profile Mode** | Show memory usage, crawl time, dedup hits, hole regions per archive. |
| 🛠️ **Syscall Tracing for Files Used** | Use `strace`/`dtruss` to trace files actually accessed during container or VM runs. |
| 🔧 **CLI Mode Split** | Distinct UX for `infogator` (recursive archival indexer) vs `infocobra` (targeted, real-time scanner). |
| 🎨 **Entropy Heatmap UI** | Interactive viewer for visualizing entropy overlaid onto file structure. Flag anomalies in real time. |


### 🏛️ Regulated Archival & Compliance (FDA / Legal / GRC)

| Requirement | Datagator Capability |
|-------------|----------------------|
| 📅 **Immutable Time-Stamped Records** | Every file, snapshot, and manifest includes cryptographic time-sealing and hash-based lineage. Proof of *when* and *what* was recorded. |
| 🧾 **21 CFR Part 11 Compliance** | Snapshot attestations satisfy audit trail, identity verification, and data integrity requirements for FDA-regulated systems. |
| 🔏 **Tamper-Evident Sealing** | Encrypted segments are sealed + signed at creation, enabling independent verification at any later time. |
| 🕵️‍♀️ **Forensic Chain of Custody** | Path, content, and metadata lineage are stored together — court-admissible and independently provable. |
| 🔐 **Access Control Snapshots** | ACLs and permission models (NTFS/ext4/APFS) are captured and diffable between snapshots. |
| 📜 **Long-Term Archival Format Support** | Supports rehydration into standardized archival formats (PDF/A, ISO bundles, etc). Preserves historical encoding and filesystem semantics. |
| 🧠 **Provenance Intelligence** | Automatically tracks source → transformation → output lineage (e.g. from CSVs to signed PDFs to analytics exports). |
| 📈 **Audit-Grade Diff Reports** | Machine-verifiable reports showing *what changed*, *when*, *by whom*, and *how* — across snapshots and overlays. |

### 🧠 AI Integrity & Trust Vectors

| Assurance Area | Datagator Capability |
|----------------|----------------------|
| ✅ **Copyright Attestation** | Tracks input sources and transformation chain to legally assert authorship or derivative works, backed by timestamped manifests. |
| ✅ **Regulatory Compliance (GDPR, EU AI Act)** | Full traceability for data origin, model training, and consent trails. Enables redaction and explainability compliance. |
| ✅ **Adversarial Training Traceability** | Attests the full provenance of training datasets and model checkpoints, enabling differential analysis and contamination rollback. |
| ✅ **Poisoned Dataset Detection** | Enables segment-level diffing of training data snapshots to identify malicious or anomalous insertions post-hoc. |
| ✅ **Academic Reproducibility** | Full model lineage: input → transformation → model → export. Guarantees reproducibility for papers, benchmarks, and citations. |


## 💀 Already Wrecked

| Product     | Description                                                                      |
|-------------|----------------------------------------------------------------------------------|
| 🐊 Datagator | Obliterated backups, antivirus, forensic kits, and CDNs                         |
| 🍿 Popcorn   | Blew up initramfs, bootloaders, install disks, and app containers               |
| ⚡ Swiftboot | Murdered bloated kernels, systemd, and full distros                             |
| 🛰️ IoT4AI    | Killed edge stacks, MDM, and opaque telemetry blobs                             |

---

## 🎯 Phase II: Next Ten Targets (Datagator Coalition Expansion)

### 1. 🛠️ Dev Environments (Dockerfiles, Vagrant, Ansible, Nix)

❌ Dead: declarative chaos  
✅ Replace with: rehydrated hash-based working sets

- Snapshots of working environments
- Instant hash-based state restore
- GitOps for actual machines, not YAML dreams

---

### 2. 📥 Package Managers (apt, yum, brew)

❌ Dead: dependency hell  
✅ Replace with: deduped segment sets with signed manifest

- Just `datagator install whip://foo`
- Package = reproducible manifest
- LAN install? Instant.
- Corrupted system? Verified fix in 2s.

---

### 3. 📦 Enterprise Storage Solutions (NetApp, EMC, Gluster)

❌ Dead: $$$ per GB  
✅ Replace with: segment dedupe + content-indexed overlay

- Global dedupe store
- Versioned snapshots
- Cross-site sync over commodity drives

---

### 4. 🔑 Secure Vaults / Secrets Managers (Vault, AWS KMS)

❌ Dead: opaque black boxes  
✅ Replace with: manifest-backed, attestable secrets as signed content blobs

- Secrets versioned like any other file
- Encrypted segment + ACL snapshot + signature = proof, not obscurity

---

### 5. 🧠 ML Model Registries (MLFlow, HuggingFace Hub)

❌ Dead: no provable lineage  
✅ Replace with: signed corpus → model → snapshot lineage

- Train from a datagator manifest
- Publish model with attached input hash chain
- Legal & reproducible ML for regulated markets

---

### 6. 🧾 SBOM Generators (CycloneDX, SPDX)

❌ Dead: post-facto guesses  
✅ Replace with: cryptographic, timestamped manifests at source

- Don’t scan for SBOMs — snapshot and sign them
- `datagator attest` replaces a dozen brittle scanners

---

### 7. 🧑‍⚖️ Regulatory Proof Engines (GRC tools, audit loggers)

❌ Dead: log-based illusions  
✅ Replace with: immutable content lineage + ACL trail + segment history

- Proof not that “someone said it happened”
- Proof that “the content was what they said it was”

---

### 8. 🛜 Internet of Shit Platforms (Home Assistant, OpenHAB, Alexa)

❌ Dead: “app” = bloat + spyware  
✅ Replace with: minimal trusted kernels + hash-based configs

- IoT boot via Popcorn
- Datagator syncs only what’s needed
- Remove vendor clouds completely

---

### 9. 💡 BI + Analytics Tools (Tableau, PowerBI, Snowflake)

❌ Dead: data warehouse tax  
✅ Replace with: reconstructable, timestamped content snapshots with lineage

- Why warehouse stale data?
- Just query across historical deduped segments
- Time-travel queries against reality itself

---

### 10. 🕵️‍♂️ Digital Evidence Chains (eDiscovery, Cellebrite, XRY)

❌ Dead: fragile, unverifiable extractions  
✅ Replace with: immutable time-linked snapshots with full path + hash chain

- Forensically perfect
- Court admissible
- Immutable provenance

---

## 🔥 Bonus Round: Future Kills

- 🎙️ Audio/video codecs → Why compress when segments dedupe better?
- 🌐 HTTP → Replace with content mesh
- 📲 App Stores → Just publish manifests
- 💬 Messaging → Segmentized, snapshot-signed trails
- 🧳 VPNs → Overlay only verified segments

---

## 🧬 TL;DR

If it:

- Syncs
- Stores
- Proves
- Packages
- Protects
- Compresses
- Or deploys…

…it’s a **Datagator target**.

---

### Ready to pick one and go nuclear?

Because we’re not disrupting industries —  
**We’re dismantling illusions.** 🐊🧨💾

