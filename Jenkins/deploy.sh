#!/bin/bash
scp -r ./target/scala-2.11/*.jar 35.202.16.214:~/artifact
java -jar ~/artifact/*.jar
