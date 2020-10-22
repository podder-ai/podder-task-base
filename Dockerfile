FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    python3.8 python3-pip locales \
    curl wget git vim iputils-ping dnsutils \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& ln -sf /usr/bin/python3.8 /usr/local/bin/python \
&& ln -sf /usr/bin/python3.8 /usr/local/bin/python3 \
&& python -m pip install -U pip setuptools poetry \
&& ln -sf /usr/local/bin/pip3 /usr/local/bin/pip \
&& locale-gen en_US.UTF-8

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    PYTHONIOENCODING=utf-8 \
    APP_ROOT=/app_root \
    PYTHONPATH="${PYTHONPATH}:/app_root/app"

WORKDIR ${APP_ROOT}

# ========== Custom Settings ==========
# Please install the libraries if necessary.

# ========== END ==========

# Install python packages
COPY poetry.lock pyproject.toml ${APP_ROOT}/
RUN poetry config virtualenvs.create false && poetry install

COPY . ${APP_ROOT}
CMD ["python", "manage.py"]
