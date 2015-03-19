# Copyright 2015 Robert Van Voorhees
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM voor:java8

ENV MAVEN_VERSION 3.2.5

RUN yum install -y tar &&\
  mkdir -p /usr/local/apache-maven &&\
  curl -Ls http://search.maven.org/remotecontent?filepath=org/apache/maven/apache-maven/$MAVEN_VERSION/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xz -C /usr/local/apache-maven &&\
  ln -sf /usr/local/apache-maven/apache-maven-$MAVEN_VERSION/bin/mvn /usr/local/bin/mvn &&\
  echo 'export M2_HOME=/usr/local/apache-maven/apache-maven-$MAVEN_VERSION' >> /etc/profile.d/mvn.sh &&\
  echo 'export M2=\$M2_HOME/bin' >> /etc/profile.d/mvn.sh &&\
  echo 'export MAVEN_OPTS="-Xmx2g -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=512m"' >> /etc/profile.d/mvn.sh &&\
  yum erase -y tar &&\
  mvn -v
