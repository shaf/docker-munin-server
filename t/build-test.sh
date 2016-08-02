#!/bin/bash

curl -sI http://$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' munin-server)/munin-cgi/munin-cgi-graph/test | grep -q 'Content-Type: image/png'
