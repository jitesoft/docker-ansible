FROM registry.gitlab.com/jitesoft/dockerfiles/python:3
ARG VERSION
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/ansible" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/ansible/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/ansible" \
      com.jitesoft.app.ansible.version="${VERSION}"

ARG VERSION
COPY ./entrypoint /usr/local/bin
RUN apk add --no-cache --virtual .build-deps gcc libc-dev libffi-dev openssl-dev \
 && chmod +x /usr/local/bin/entrypoint \
 && addgroup -g 721 ansible \
 && adduser -u 721 -G ansible -s /bin/ash -D ansible \
 && su - ansible -c "/usr/local/bin/pip install ansible==${VERSION} --user" \
 && apk del .build-deps
USER ansible
ENV PATH="/usr/local/bin:/home/ansible/.local/bin:$PATH"
ENTRYPOINT [ "entrypoint" ]
CMD [ "ansible", "--version" ]


