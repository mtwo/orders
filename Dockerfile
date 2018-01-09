FROM weaveworksdemos/msd-java:jre-latest

WORKDIR /usr/src/app
COPY ./target/*.jar ./app.jar
COPY ./cdbg/cdbg_java_agent_internals.jar ./cdbg_java_agent_internals.jar
COPY ./cdbg/cdbg_java_agent.so ./cdbg_java_agent.so

RUN	chown -R ${SERVICE_USER}:${SERVICE_GROUP} ./app.jar

USER ${SERVICE_USER}

ENTRYPOINT ["/usr/local/bin/java.sh","-jar","./app.jar", "-agentpath:/cdbg_java_agent.so", "--port=80"]