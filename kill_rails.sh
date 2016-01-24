#!/bin/bash
# My test scripts for blocitoff
# $./kills_rails.sh to execute
echo "Kill current rails server"

lsof -i :3000    # returns the PID of the process using port 3000 (the port Rails server uses).

echo "Kill -9 [pid] to kill the server"


