FROM redfactorlabs/concourse-smuggler-resource:alpine as smuggler

FROM concourse/s3-resource

# Rename the old resource
RUN mkdir -p /opt/resource/wrapped && \
    mv /opt/resource/check /opt/resource/wrapped/ && \
    mv /opt/resource/in /opt/resource/wrapped/ && \
    mv /opt/resource/out /opt/resource/wrapped/

# Put smuggler in place
COPY --from=smuggler /opt/resource/smuggler /opt/resource/smuggler
RUN ln /opt/resource/smuggler /opt/resource/check \
    && ln /opt/resource/smuggler /opt/resource/in \
    && ln /opt/resource/smuggler /opt/resource/out

ADD smuggler.yml /opt/resource/smuggler.yml

RUN apk add --update jq  && rm -rf /var/cache/apk/*
