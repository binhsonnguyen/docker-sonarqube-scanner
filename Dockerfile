FROM java:8-jre-alpine

RUN apk update && apk add --no-cache curl git python3
RUN pip3 install --upgrade pip pylint setuptools

WORKDIR /root

ARG LATEST

RUN env && \
  mkdir sonar-temp &&\
  curl --insecure -OL 'https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/'$LATEST.zip && \
  unzip $LATEST.zip -d sonar-temp && mv sonar-temp/* sonar-home && rm -rf sonar-temp &&  \
  rm $LATEST.zip

ENV SONAR_RUNNER_HOME=/root/sonar-home
ENV PATH="${SONAR_RUNNER_HOME}/bin:${PATH}"

CMD echo (ls /root/$LATEST/bin)
CMD sonar-scanner -Dsonar.projectBaseDir=./src

