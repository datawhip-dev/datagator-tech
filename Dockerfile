FROM fedora:40

RUN dnf install -y \
    postgresql-server postgresql postgresql-contrib \
    bash coreutils curl unzip wget gnupg2 \
    e2fsprogs attr file gawk sed util-linux findutils \
    java-17-openjdk-headless supervisor \
    && dnf clean all

# Install Flyway manually
ENV FLYWAY_VERSION=10.11.0
RUN curl -L https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}-linux-x64.tar.gz \
    | tar xz -C /opt && \
    ln -s /opt/flyway-${FLYWAY_VERSION}/flyway /usr/local/bin/flyway

# Placeholder for pgquarrel (should be added manually or built from source)
RUN echo "# pgquarrel should be downloaded and installed manually or added via volume"

ENV PGDATA=/mnt/volume/__postgresql

RUN useradd -ms /bin/bash scanner
USER scanner
WORKDIR /home/scanner

VOLUME ["/mnt/volume"]

CMD ["/bin/bash", "-c", "\
  if [ ! -s /mnt/volume/__postgresql/PG_VERSION ]; then \
    initdb --username=postgres --pwfile=<(echo secret); \
  fi && \
  exec postgres -D /mnt/volume/__postgresql \
"]
