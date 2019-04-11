#!/bin/sh

while [[ ! -f ./stop ]]; do
  git add -A && git commit -m "wip" && git push
  sleep 5m
done

