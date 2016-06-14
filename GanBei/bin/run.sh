#!/bin/bash

jars=$(find target -name \*.jar 2>/dev/null)

if [ -z "$jars" ]; then
  sbt package
  jars=$(find target -name \*.jar 2>/dev/null)
fi

if [ ! -z "$jars" ]; then
  scala -cp $jars qnix.example.GanBei
else
  echo "Failed to build project jar"
fi
