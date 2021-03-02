# hepcloud/decision-engine-ci
FROM sl:7

# You can select another version at container build time by setting
# this value to the expected version - ie 9.6
ARG PG_VERSION=11

# Extra repos we need
RUN yum install -y http://ftp.scientificlinux.org/linux/scientific/7x/repos/x86_64/yum-conf-softwarecollections-2.0-1.el7.noarch.rpm \
  && yum -y clean all
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
  && yum -y clean all

# set PATH for build and runtime
ENV PATH="~/.local/bin:/usr/pgsql-${PG_VERSION}/bin:$PATH"
ARG PATH="~/.local/bin:/usr/pgsql-${PG_VERSION}/bin:$PATH"
# Install postgresql-${PG_VERSION}
RUN yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
  && yum -y clean all
RUN yum -y install postgresql$(echo -n ${PG_VERSION} | tr -d '.')-server \
                   postgresql$(echo -n ${PG_VERSION} | tr -d '.')-devel \
                   postgresql$(echo -n ${PG_VERSION} | tr -d '.') \
  && yum -y clean all

# Install utils
RUN yum -y install \
  python3 python3-devel python3-pip python3-wheel \
  gcc gcc-c++ make \
  git \
  rpm-build \
  && yum -y clean all

RUN git clone https://github.com/HEPCloud/decisionengine.git /tmp/decisionengine.git
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade setuptools wheel setuptools-scm[toml]
RUN cd /tmp/decisionengine.git ; python3 setup.py develop ; python3 -m pip install decisionengine[develop] ; python3 setup.py develop --uninstall

ENTRYPOINT ["/bin/bash"]
