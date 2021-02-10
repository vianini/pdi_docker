FROM openjdk:8

MAINTAINER Gustavo Vianini
LABEL Pentaho='Pentaho PDI'

# Init ENV
ENV PDI_VERSION 9.1
ENV PDI_TAG 9.1.0.0-324
ENV PDI_HOME /opt/PDI

# Apply JAVA_HOME

ENV JAVA_HOME /usr/local/openjdk-8
RUN . /etc/environment \
 export JAVA_HOME

# Install Dependences
RUN apt-get update; apt-get install zip -y; \
apt-get install wget unzip git vim -y; \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

RUN mkdir ${PDI_HOME}; 
RUN chown -R root ${PDI_HOME}

# Download Pentaho PDI
RUN /usr/bin/wget --progress=dot:giga \
"http://downloads.sourceforge.net/project/pentaho/Pentaho%20${PDI_VERSION}/client-tools/pdi-ce-${PDI_TAG}.zip" \
-O /tmp/pdi-ce-${PDI_TAG}.zip; \
/usr/bin/unzip -q /tmp/pdi-ce-${PDI_TAG}.zip -d $PDI_HOME; 
RUN rm -f /tmp/pdi-ce-${PDI_TAG}.zip  

RUN chmod +x $PDI_HOME/data-integration/kitchen.sh
RUN chmod +x $PDI_HOME/data-integration/pan.sh 

RUN mkdir $PDI_HOME/data-integration/entry 
RUN chown -R root $PDI_HOME/data-integration/entry

#Diretorio dos Etl files 
RUN mkdir $PDI_HOME/data-integration/etl
RUN chown -R root $PDI_HOME/data-integration/etl

#ADD DB drivers
RUN chown -R root $PDI_HOME/data-integration/lib
COPY ./lib/. $PDI_HOME/data-integration/lib

COPY ./entry/script.sh $PDI_HOME/data-integration/entry
RUN chmod +x $PDI_HOME/data-integration/entry/script.sh


ENTRYPOINT ["/opt/PDI/data-integration/entry/script.sh"]

