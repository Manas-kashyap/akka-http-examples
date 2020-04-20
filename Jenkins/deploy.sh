#!/bin/bash
scp -r ./target/scala-2.11/*.jar 35.202.16.214:~/artifact
ssh 35.202.16.214
sudo apt install default-jdk -y
java -jar ~/artifact/*.jar