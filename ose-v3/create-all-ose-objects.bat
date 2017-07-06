@echo off

REM get base-centos7 image
oc import-image openshift/base-centos7:latest -n openshift --confirm

REM Adding templates to namespace
oc apply -f springboot-s2i-template.json

REM Processing templates with default params
oc process  springboot-s2i-template | oc apply -f -
