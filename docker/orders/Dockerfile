# FROM weaveworksdemos/msd-java:jre-latest

# RUN apt update -y
# RUN apt upgrade -y
# RUN apt install -y wget
# RUN apk add --update openssl
# RUN apk add libc6-compat

# RUN mkdir -p /opt
# RUN mkdir -p /opt/cdbg
# RUN wget -qO- https://storage.googleapis.com/cloud-debugger/compute-java/debian-wheezy/cdbg_java_agent_gce.tar.gz | tar xvz -C /opt/cdbg

# WORKDIR /usr/src/app
# COPY orders.jar ./app.jar

# RUN	chown -R ${SERVICE_USER}:${SERVICE_GROUP} ./app.jar

# USER ${SERVICE_USER}

# ENTRYPOINT ["java", "-agentpath:/opt/cdbg/cdbg_java_agent.so", "-Dcom.google.cdbg.module=module1", "-Dcom.google.cdbg.version=version1", "-jar", "./app.jar", "--port=80"]



FROM weaveworksdemos/msd-java:jre-latest


RUN apk add --update openssl


# RUN mkdir -p /opt/cprof
# RUN wget -q -O- https://storage.googleapis.com/cloud-profiler/java/latest/profiler_java_agent.tar.gz | tar xzv -C /opt/cprof


RUN apk --no-cache add bash git curl gcc g++ make cmake python maven openjdk8
RUN git clone https://github.com/GoogleCloudPlatform/cloud-debug-java

WORKDIR cloud-debug-java
RUN bash build.sh
RUN mkdir -p /opt/cdbg
RUN tar -xvf cdbg_java_agent_service_account.tar.gz -C /opt/cdbg


WORKDIR /usr/src/app
COPY *.jar ./app.jar

RUN	chown -R ${SERVICE_USER}:${SERVICE_GROUP} ./app.jar

USER ${SERVICE_USER}

ENTRYPOINT ["-agentpath:/opt/cdbg/cdbg_java_agent.so", "-Dcom.google.cdbg.module=orders", "-Dcom.google.cdbg.version=VERSION", "/usr/local/bin/java.sh", "-jar", "./app.jar", "--port=80"]

# "-agentpath:/opt/cprof/profiler_java_agent.so=-cprof_service=orders"