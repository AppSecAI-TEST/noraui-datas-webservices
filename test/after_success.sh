#!/bin/bash
cd project
if [ "$TRAVIS_BRANCH" = 'master' ] && [ "$TRAVIS_PULL_REQUEST" == 'false' ]; then
    mvn_version=$(mvn -q -Dexec.executable="echo" -Dexec.args='${project.version}' --non-recursive org.codehaus.mojo:exec-maven-plugin:1.5.0:exec)
    echo "Maven version is $mvn_version"
    if [[ $mvn_version == *"-SNAPSHOT" ]]; then
        echo "******** Starting deploy snapshot"
        mvn clean deploy -Psnapshot --settings ../test/mvnsettings.xml -DskipTests=true
        exit $?
    fi
fi
