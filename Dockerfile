FROM python:3

RUN useradd -ms /bin/sh user

COPY requirements.txt /home/user
COPY Dockerfile /home/user
COPY hss_server /home/user/hss_server
COPY setup.py /home/user
COPY README.md /home/user
COPY scripts /home/user/scripts

WORKDIR /home/user

RUN pip install -r requirements.txt && python3 setup.py install

COPY ./config /home/user/.config/hss_server

RUN chown -R 1000 /home/user/.config/hss_server

USER 1000

ENTRYPOINT ["hss-server", "-p", "12183"]
