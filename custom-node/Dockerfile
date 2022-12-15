FROM docker.io/kindest/node:v1.26.0
COPY ./kubelet /usr/bin/kubelet
RUN echo "Installing crio ..." \
    && DEBIAN_FRONTEND=noninteractive clean-install gnupg \
    && echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/1.25/xUbuntu_22.04/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list \
    && curl -fSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_22.04/Release.key | apt-key add - \
    && rm -rf /etc/crictl.yaml \
    && DEBIAN_FRONTEND=noninteractive clean-install cri-o crun
RUN systemctl disable containerd \
    && systemctl enable crio \
    && rm -rf /etc/crio/crio.conf.d/01-crio-runc.conf \
    && echo "_CRIO_ROOTLESS=1" >> /etc/default/crio
COPY crio.conf /etc/crio/crio.conf
COPY local-registry.conf /etc/containers/registries.conf.d
COPY crio /usr/bin/crio
