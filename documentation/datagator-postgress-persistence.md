## 🗃️ PostgreSQL Data Directory Preparation (DataGator Core)

To ensure proper PostgreSQL operation within the container, your host system **must prepare a writable data directory** for the container to mount. This directory is where PostgreSQL stores its internal files.

There are two supported strategies:

---

### 🔧 Option 1: Bind Mount to a Canonical PostgreSQL Directory

If your container manager supports proper **UID mapping and permission passthrough**, you may directly bind-mount a canonical `PGDATA` directory from the host:

```bash
mkdir -p /opt/datagator/pgdata
chown 1200:1200 /opt/datagator/pgdata  # Ensure UID 1200 matches 'postgres' inside the container
chmod 700 /opt/datagator/pgdata
```

Then launch your container with:

```bash
docker run -v /opt/datagator/pgdata:/opt/datagator/pgdata ...
```

Or using `podman`, `compose`, or `kubernetes` with equivalent bind-mount volume mapping.

✅ PostgreSQL will initialize and persist data directly to the mounted directory.

---

### 🧳 Option 2: Use Fallback Tarball Persistence

If UID mismatch prevents bind-mounted directories from working (common on macOS, Windows, or rootless containers), the script will **automatically fall back to an ephemeral in-container database** with a persistence tarball:

- The container creates `/tmp/pgdata-ephemeral-<HOSTNAME>`
- On shutdown, it saves a compressed tarball to:

```bash
/opt/datagator/pgdata/pgsql.tar.zst
```

To enable this mode:

```bash
mkdir -p /opt/datagator/pgdata
chmod 755 /opt/datagator/pgdata
```

🚨 **Do not chown to UID 1200** if you want fallback mode! That would trigger Option 1 instead.

✅ Your data will persist via tarball between container runs, even without direct PGDATA bind support.

---

### 🧠 Tip: Which mode am I using?

Check container logs:

- `✅ PGDATA set to new default:` → using direct directory mode
- `⚠️ UID mismatch ... Using isolated fallback database instance` → using tarball mode

Both modes are valid and production-safe if used correctly.

---

### 📤 Backing Up or Migrating

In fallback mode, the tarball can be copied off-host:

```bash
cp /opt/datagator/pgdata/pgsql.tar.zst my_backup.tar.zst
```

Or unpacked manually if needed:

```bash
zstd -dc pgsql.tar.zst | tar -xf -
```

---

For questions or debugging, inspect:

- `PGDATA` environment inside container
- `/tmp/pgdata-*` directories
- `/opt/datagator/pgdata/pgsql.tar.zst` existence

---

🛠️ **Advanced container managers may support user namespaces, volume drivers, or CSI that enable Option 1 even under constraints.**

