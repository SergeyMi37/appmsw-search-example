ARG IMAGE=intersystemsdc/iris-community:2021.1.0.215.3-zpm
FROM $IMAGE

USER root   
        
# Install unzip
RUN apt-get update && apt-get install -y unzip

WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp
USER ${ISC_PACKAGE_MGRUSER}

COPY iris iris
COPY db-zip db-zip
COPY src src
COPY module.xml module.xml
COPY iris.script /tmp/iris.script

RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
    && iris stop IRIS quietly
