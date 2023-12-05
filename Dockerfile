# syntax=docker/dockerfile-upstream:master-labs

ARG BUILDER_IMAGE=quay.io/vexxhost/openstack-builder-focal
ARG RUNTIME_IMAGE=quay.io/vexxhost/openstack-runtime-focal

FROM quay.io/vexxhost/bindep-loci:latest AS bindep

FROM ${BUILDER_IMAGE}:1e91e346ed4164361923475e3cfb6f8bc433cb70 AS builder
COPY --from=bindep --link /runtime-pip-packages /runtime-pip-packages

FROM ${RUNTIME_IMAGE}:a391e31bb33041611e2aa2797debcb21e6f221cd AS runtime
COPY --from=bindep --link /runtime-dist-packages /runtime-dist-packages
COPY --from=builder --link /var/lib/openstack /var/lib/openstack
ADD https://github.com/novnc/novnc.git#v1.3.0 /usr/share/novnc
