# 🧠 DataGator Verb Expectations (Power User Reference)

| Verb              | Description                                        | Key Flags / Args                  | Output Behavior                               | Exit Codes                    |
|-------------------|----------------------------------------------------|-----------------------------------|-----------------------------------------------|-------------------------------|
| `doctor`          | Run full system diagnostics                        | `--details`, `--json`             | Status report: tools, DB, schema, mount, etc. | `0` on pass                   |
| `verify`          | Validate YAML, manifests, and SQL integrity        | `--manifest`, `--schema`, `--all` | Prints results of static checks               | `0` pass, `1` fail            |
| `reset`           | Destroy and reinit ephemeral DB + state            | `--force`, `--dry-run`            | Prompts unless forced                         | `0` OK, `1` refused           |
| `condense`        | GC, dedup, archive stale sessions and volumes      | `--older-than`, `--archive-out`   | Log of deletions, optional archive path       | `0` always                    |
| `import <file>`   | Import structured JSON or YAML export              | `--validate`, `--dry-run`         | Summary of rows inserted                      | `0` success, `1` format error |
| `export <filter>` | Export records by host, session, or table          | `--host`, `--session`, `--out`    | JSON or YAML to stdout or file                | `0` on export                 |
| `scan`            | Ingest volumes from `scan.yaml` into `file_scan`   | `--volume`, `--path`, `--tags`    | Logs each inserted scan/volume                | `0` on success                |
| `rescan`          | Replay last `scan.yaml`, refresh file scan records | `--clean-first`, `--session`      | Clears and replaces file scan data            | `0` on success                |
| `dev_server`      | Start ephemeral dev container stack                | `--detach`, `--bind`, `--port`    | Launch logs, connection info                  | `0` on success                |