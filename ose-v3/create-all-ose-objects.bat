@echo off

REM Adding templates to namespace
oc apply -f springboot-s2i-template.json

REM Processing templates with default params
oc process  springboot-s2i-template | oc create -f -
