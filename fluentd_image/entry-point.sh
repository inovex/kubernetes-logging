#!/bin/bash

sed -i "s/elasticsearch-logging/${ELASTICSEARCH_LOGGING_SERVICE_HOST}/g" /etc/td-agent/td-agent.conf

td-agent