ARG APPNAME \
    WORKDIR \
    APPUID \
    APPGID \
    APPUSER \
    APPGROUP


FROM python:3.12-alpine as python-base
ARG APPNAME \
    WORKDIR
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_ROOT_USER_ACTION=ignore \
    PIP_NO_CACHE_DIR=off \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_NO_INTERACTION=1 \
    APPNAME=${APPNAME:?} \
    WORKDIR=${WORKDIR:?}
RUN apk add --no-cache --upgrade \
        coreutils \
        tzdata; \
    rm -rf /var/cache/apk/*;


FROM python-base AS builder
WORKDIR ${WORKDIR:?}
RUN apk add --no-cache --upgrade \
        build-base \
        libffi-dev; \
    pip install poetry;
COPY . ${WORKDIR:?}/
RUN poetry config virtualenvs.in-project true; \
    poetry install --no-ansi;


FROM python-base AS production
ARG APPUID \
    APPGID \
    APPUSER \
    APPGROUP
WORKDIR ${WORKDIR:?}
COPY --from=builder ${WORKDIR:?} ${WORKDIR:?}
COPY . ${WORKDIR:?}/
RUN addgroup --gid ${APPGID:?} ${APPGROUP:?}; \
    adduser \
        --disabled-password \
        --gecos "" \
        --home ${WORKDIR:?} \
        --ingroup ${APPGROUP:?} \
        --no-create-home \
        --uid ${APPUID:?} \
    ${APPUSER:?}; \
    chown -R ${APPUSER:?}:${APPGROUP:?} ${WORKDIR:?}/*
USER ${APPUSER:?}
