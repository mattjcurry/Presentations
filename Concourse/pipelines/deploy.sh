#!/usr/bin/env bash

fly --target concourse-lite login  --concourse-url http://192.168.100.4:8080
fly -t concourse-lite sync
fly -t concourse-lite destroy-pipeline -n -p basic_pattern
fly -t concourse-lite destroy-pipeline -n -p basic_pipeline
fly -t concourse-lite set-pipeline -c basic_platform_pattern.yml -p basic_pattern
fly -t concourse-lite set-pipeline -c basic_platform_pipeline.yml -p basic_pipeline
fly -t concourse-lite unpause-pipeline -p basic_pattern
fly -t concourse-lite unpause-pipeline -p basic_pipeline
