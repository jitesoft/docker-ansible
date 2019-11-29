FROM jitesoft/python:3
ARG VERSION
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/node-base" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/node-base/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/node-base" \
      com.jitesoft.app.ansible.version="${VERSION}"

ARG VERSION
COPY ./entrypoint /usr/local/bin
RUN apk add --no-cache --virtual .build-deps gcc libc-dev libffi-dev openssl-dev \
 && addgroup -g 721 ansible \
 && adduser -u 721 -G ansible -s /bin/ash -D ansible \
 && su - ansible -c "pip install ansible==${VERSION} --user" \
 && apk del .build-deps \
 && chmod +x /usr/local/bin/entrypoint
USER ansible
ENV PATH="/home/ansible/.local/bin:$PATH"
ENTRYPOINT [ "entrypoint" ]
CMD [ "ansible", "--version" ]
