FROM antik486/centos71

RUN yum update -y && \
    yum install -y apache-commons-beanutils make && \
    rm -rf /var/lib/apt/lists/*

#ENV DISTRIBUTION_DIR /go/src/github.com/docker/distribution
ENV DISTRIBUTION_DIR ./distribution
ENV DOCKER_BUILDTAGS include_oss include_gcs

WORKDIR $DISTRIBUTION_DIR
COPY . $DISTRIBUTION_DIR
COPY cmd/registry/config-dev.yml /etc/docker/registry/config.yml
#RUN make PREFIX=/go clean binaries
RUN make  clean binaries

VOLUME ["/var/lib/registry"]
EXPOSE 5000
ENTRYPOINT ["registry"]
CMD ["serve", "/etc/docker/registry/config.yml"]
