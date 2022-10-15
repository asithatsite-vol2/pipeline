FROM docker.io/library/ubuntu:22.04
# Mapshot version, "X.Y.Z"
ENV MAPSHOT_VERSION=0.0.15

# xvfb, tini for container
# xz-utils for build
# libx*, etc for factorio
RUN --mount=type=cache,target=/var/lib/apt apt-get update && apt-get install -y \
  xvfb xz-utils tini libxinerama1 libxrandr2 libxcursor1 libasound2 libpulse0

# Set up factorio
COPY factorio.tar.xz /tmp/factorio.tar.xz
RUN tar -xaf /tmp/factorio.tar.xz -C /opt
COPY mods/* /opt/factorio/mods

# Set up mapshot
ADD https://github.com/Palats/mapshot/releases/download/${MAPSHOT_VERSION}/mapshot-linux /usr/local/bin/mapshot
COPY mapshot-render.sh /usr/local/bin/mapshot-render
RUN chmod a+x /usr/local/bin/mapshot /usr/local/bin/mapshot-render

VOLUME /opt/factorio/saves
VOLUME /opt/factorio/script-output

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/bin/xvfb-run", "--"]
CMD ["render"]
