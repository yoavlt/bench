#!/bin/sh

# lein run -m clj.core
lein uberjar clj.core
java -jar ./target/clj-0.1.0-SNAPSHOT-standalone.jar
