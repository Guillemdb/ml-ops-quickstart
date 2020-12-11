FROM fragiletech/ubuntu20.04-base-py38
ARG JUPYTER_PASSWORD=""
ENV BROWSER=/browser \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8

COPY Makefile Makefile
COPY requirements.txt requirements.txt
COPY pyproject.toml pyproject.toml

COPY . mltemplate/

RUN cd mltemplate && pip3 install -r requirements.txt  \
    && pip install ipython jupyter \
    && pip3 install -e . --no-use-pep517
RUN make remove-dev-packages
RUN mkdir /root/.jupyter && \
    echo 'c.NotebookApp.token = "'${JUPYTER_PASSWORD}'"' > /root/.jupyter/jupyter_notebook_config.py
CMD pipenv run jupyter notebook --allow-root --port 8080 --ip 0.0.0.0