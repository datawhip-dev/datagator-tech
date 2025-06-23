# 🧠 DataGator: Forensic-Grade Filesystem Indexer & Deduplicator

DataGator is a portable, one-container, test-driven, forensic-capable filesystem inventory and deduplication system.  
It models every file, directory, stream, and mount with cryptographic precision — and makes it queryable, syncable, and permanent.

---

## 🚀 What It Does

| Capability                    | Description                                                                 |
|------------------------------|-----------------------------------------------------------------------------|
| 🗂 Full Filesystem Indexing  | Recursively indexes all files, directories, streams on a bind-mounted root |
| 🔑 Cryptographic Fingerprints | MD5 + SHA256 for every file, stream, and normalized path segment            |
| 🧬 Unicode-Aware Paths       | NFC/NFD normalization, segment-based, metadata-safe                          |
| 🔁 Deduplication-Ready       | Stores content by hash; dedupe can be applied externally                     |
| 🕵️ Drift Detection           | Rehashes files to detect corruption or bitrot                                |
| 🧰 Composite Support         | Supports containers like `.zip`, `.vhd`, `.iso` with plugin scanning         |
| 🔌 Multi-Volume, Multi-Machine | Knows which machine and which volume each file appears on                  |
| 📊 Dashboard + Reports       | Periodic HTML dashboard written to a bind-mounted path                       |
| 🧪 Test-Driven                | All shell and AWK logic comes with unit tests                               |
| 🔐 CI/Precommit Sanity       | Detects missing tests and prevents silent rot                                |

---

## 🏗 Why It Exists

Most file indexes fail when:
- Filenames contain control characters
- Filesystems mismatch case sensitivity
- Paths are deeply nested or weirdly encoded
- Hardlinks, symlinks, ACLs, ADS, and NTFS streams go untracked
- Snapshots, USB volumes, and sync targets drift

DataGator was built to:
> **Create a perfect, portable, forensic map of what you have and where it lives — from top to bottom.**

---

## 🧱 Core Concepts

### 📁 Path Segments Are Canonical

DataGator treats paths as **ordered lists of segments**, each:
- UTF-8 encoded
- Percent-escaped (no `/`, `NUL`, or invisible bytes)
- Normalized (NFC or NFD declared)
- Hashed after **PUA stripping**

> A file's identity lives in its **segments**, not its `/`.

---

### 🧬 Unicode: Canonical + Raw

- Canonical path = normalized + encoded
- Raw path = exact UTF-8 bytes from FS
- Both are stored; **only canonical path is hashed**

---

### 🔀 Hash Policy Summary

| Item        | SHA256/MD5 source                       |
|-------------|-----------------------------------------|
| File        | File contents                           |
| Directory   | Canonical relative path string          |
| Path Segment| PUA-stripped, normalized segment string |
| Path Chain  | Joined canonical segments               |
| Streams     | Individual stream contents              |

---

### 🧪 Test-Driven Everything

Each module has:
- `scripts/lib/foo.sh` → `scripts/lib/tests/foo_test.sh`
- `scripts/lib/bar.awk` → `scripts/lib/tests/bar_awk_test.sh`

Run all tests:
```bash
find scripts -name '*_test.sh' -exec bash {} \;
```

---

## 🛠 How To Use

### 📦 1. Mount a Filesystem

```bash
docker run --rm \
  -v /your/volume:/mnt/fsroot:ro \
  -v ~/.DataGator.id:/etc/DataGator.id:ro \
  DataGator-container
```

### 🧾 2. Scan and Index

```bash
./scan_fs.sh /mnt/fsroot
```

### 🔍 3. Check Drift

```bash
./drift_detector.sh
```

### 📊 4. View Dashboard

Open `__postgresql/dashboard/index.html` in a browser.

---

## ⚠️ Gotchas & Notes

| 🔍 Issue                         | 📌 Resolution                          |
|----------------------------------|----------------------------------------|
| Control characters in filenames | Encoded safely, preserved in raw path |
| PUA metadata in Unicode         | Stripped for hashing, stored if raw   |
| File deletions                  | Marked as disappeared, never removed  |
| Streams (NTFS ADS)              | Treated as child files                |
| Snapshots                       | Mounted and indexed like volumes      |
| Sync                            | Segment-based + chunk hash mapping    |

---

## 🤝 Contribute

- Every module must include a test.
- Run `scripts/tools/check_missing_tests.sh` to sanity check.
- Add plugins for `.zip`, `.vhd`, etc in `plugins/` (coming soon).
- Normalize with love. Encode like a purist. Hash like a cryptographer.

---

## 📚 Philosophy

> "We do not store files — we store truth.  
>  Names are not paths — they are sequences of intention."  
>  — DataGator Design Memo #001

---

## 🧩 Future

- 📡 Sync peer-to-peer by content segment
- 🧠 AI diff on path and content drift
- 💽 Snapshot-aware versioning and recovery
- 💌 USB auto-ingest with dedupe verification
- 🌐 Federated hash sharing and archival nets

---

## 🛠 Maintained By

You.  
Locally.  
Free and open-source.  
**Forever.**
