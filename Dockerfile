FROM openjdk:8
LABEL maintainer = "Benjamin Weder <weder@iaas.uni-stuttgart.de>"

ARG CAMUNDA_VERSION=7.14

# install the Camunda engine
RUN curl -LO https://downloads.camunda.cloud/release/camunda-bpm/run/$CAMUNDA_VERSION/camunda-bpm-run-$CAMUNDA_VERSION.0.tar.gz \
    && tar xzvf camunda-bpm-run-$CAMUNDA_VERSION.0.tar.gz \
    && rm camunda-bpm-run-$CAMUNDA_VERSION.0.tar.gz

# add history extensions files
RUN mkdir -p META-INF/resources/webjars/camunda/app/cockpit/scripts/ 
COPY history-scripts META-INF/resources/webjars/camunda/app/cockpit/scripts/

# update JAR with history extension
RUN jar uf internal/webapps/camunda-webapp-webjar-$CAMUNDA_VERSION.0.jar META-INF

EXPOSE 8080

CMD bash start.sh
