FROM docker.io/library/ubuntu:22.04
# Mapshot version, "X.Y.Z"
ENV MAPSHOT_VERSION=0.0.15

# xvfb, tini for container
# xz-utils for build
# libx*, etc for factorio
# Python for CI later
# TODO:BUILDX: --mount=type=cache,target=/var/lib/apt
RUN apt-get update && apt-get install -y \
  xvfb xz-utils tini python3 libxinerama1 libxrandr2 libxcursor1 libasound2 libpulse0 \
  && rm -rf /var/lib/apt

# Set up factorio
COPY factorio.tar.xz /tmp/factorio.tar.xz
RUN tar -xaf /tmp/factorio.tar.xz -C /opt
RUN rm /tmp/*

# Set up mapshot
ADD https://github.com/Palats/mapshot/releases/download/${MAPSHOT_VERSION}/mapshot-linux /usr/local/bin/mapshot
COPY mapshot-render.sh /usr/local/bin/mapshot-render
RUN chmod a+x /usr/local/bin/mapshot /usr/local/bin/mapshot-render

# COPY mods /opt/factorio/mods

VOLUME /opt/factorio/saves
VOLUME /opt/factorio/script-output

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/bin/xvfb-run", "--server-args=-fbdir /tmp", "--error-file", "/dev/stdout", "--"]
