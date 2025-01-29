FROM quay.io/centos/centos:stream10 AS scudo-builder

RUN dnf install gcc-c++ kernel-headers -y && \
    curl -sO "https://android.googlesource.com/platform/external/scudo/+archive/refs/heads/main/standalone.tar.gz" && \
    tar xf standalone.tar.gz && \
    g++ -fPIC -Iinclude -c *.cpp && \
    g++ -shared -o libscudo.so *.o

FROM ghcr.io/centos-workstation/main:stream10

COPY --from=scudo-builder /libscudo.so /usr/lib64/
COPY build.sh /tmp/build.sh

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit
    
