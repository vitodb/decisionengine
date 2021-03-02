FROM hepcloud/decision-engine-ci
COPY entrypoint.sh /entrypoint.sh

# Identity information for the decisionengine user
ARG UID=500
ARG GID=500

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
WORKDIR /home/decisionengine

# get code and modules we need
RUN git clone https://github.com/HEPCloud/decisionengine.git /home/decisionengine/decisionengine/
RUN python3 -m pip install --upgrade pip --user
RUN python3 -m pip install --upgrade setuptools wheel setuptools-scm[toml] --user
RUN cd decisionengine ; python3 setup.py develop --user

USER decisionengine
ENTRYPOINT ["/entrypoint.sh"]
