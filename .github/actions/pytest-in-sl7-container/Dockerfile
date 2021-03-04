ARG BASEIMAGE=vitodb/decision-engine-ci:test
FROM ${BASEIMAGE}
COPY entrypoint.sh /entrypoint.sh

# Identity information for the decisionengine user
ARG UID=1001
ARG GID=116

# make PIP happy
ARG PATH="~/.local/bin:$PATH"
ENV PATH="~/.local/bin:$PATH"

# Make user and place for logs/configs
RUN groupadd -g $GID decisionengine
RUN useradd -u $UID -g $GID -d /home/decisionengine -m decisionengine
RUN mkdir -m 750 -p /var/log/decisionengine
RUN mkdir -m 750 -p /etc/decisionengine
RUN chown decisionengine:decisionengine /var/log/decisionengine /etc/decisionengine

# Become container user
USER decisionengine

ENTRYPOINT ["/entrypoint.sh"]
