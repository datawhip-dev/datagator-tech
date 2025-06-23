### 🧠 Recommended Behavior

| Scenario                            | Recommendation                                                   |
|-------------------------------------|------------------------------------------------------------------|
| Linux users                         | Normal `docker run` (no sudo needed)                             |
| macOS users (Docker Desktop/Colima) | Always use `sudo docker run`                                     |
| Anyone considering `--privileged`   | **Don't** unless you understand container security risks deeply. |

---

### 🚨 Why *Not* `--privileged`?

Using `--privileged`:

- Grants the container access to **all** devices on the host
- Disables kernel-level isolation safeguards
- Allows **raw socket**, **network**, **mount**, **cgroup** manipulation
- **Massively expands attack surface** even if you trust your container image

> 💬 For DataGator Core, there’s **zero** need to take this risk.  
> 💬 Just use `sudo docker run` if better bind-mount fidelity is required.

---

### 🧱 Bind Mount Behavior Matrix

| Host Platform / Runtime | Run Style                 | Inside Container User | Bind Mount Access | Notes                                             |
|-------------------------|---------------------------|-----------------------|-------------------|---------------------------------------------------|
| Linux + Docker          | `docker run`              | root                  | ✅ Full            | Default. Root sees host binds fine.               |
| Linux + Docker          | `sudo docker run`         | root                  | ✅ Full            | Same as above; sudo mostly redundant.             |
| Linux + Docker          | `docker run --user`       | non-root              | ❓ Depends         | Must match bind UID/GID or lose access.           |
| macOS + Colima          | `docker run`              | root                  | ❓ Inconsistent    | Depends on virtiofs+Colima version.               |
| macOS + Colima          | `sudo docker run`         | root                  | ✅ Full            | Preferred for bind fidelity.                      |
| macOS + Colima          | `docker run --user`       | non-root              | ❌ Blocked         | virtiofs blocks non-root bind traversal.          |
| macOS + Podman          | `podman run`              | root                  | ✅ Full            | OK, but virtiofs quirks on older versions.        |
| macOS + Podman          | `sudo podman run`         | root                  | ✅ Full            | Same.                                             |
| macOS + Podman          | `podman run --user`       | non-root              | ❓ Flaky           | Depends on version and FUSE+UID support.          |
| Any + Docker/Podman     | `docker run --privileged` | root                  | ✅ Full            | Full mount namespace. Total host FS visibility.   |

---

### ⚠️ Why Run as Root Inside the Container?

- Host bind mounts (e.g. `/mnt/data`, NAS shares) are **often unreadable** by non-root inside containers — especially on macOS.
- Running as `root` inside avoids permission errors when:
    - Crawling `ro` data trees
    - Reading through FUSE or virtiofs bridges
- DataGator **never writes** outside its sandboxed volumes.
- Use `--rm` and **read-only bind mounts** to stay safe.

```bash
# Safe default launch:
sudo docker run --rm -v /data:/opt/datagator/scandir:ro datagator:latest scan
```

---

### ✅ Summary

If you're a **Core user** scanning local filesystems:

- Use `sudo docker run` for best compatibility
- Run containers as **root inside**, but lock down host binds
- Skip `--privileged` — not worth the risk

For real FS fidelity on macOS:  
🔐 *The root container is safer than a blind scanner.*
