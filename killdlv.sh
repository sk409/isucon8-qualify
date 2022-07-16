#!/bin/bash

id=$(ps -ef | grep dlv | grep -v grep | awk '{print $2}')
kill $id