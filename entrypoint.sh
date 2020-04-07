#!/bin/sh
cd /github/workspace/

if [ -f "${1}/config.yml" ] && [ -f "${1}/CHANGELOG.tpl.md" ]; then
  /usr/local/bin/git-chglog --next-tag "${2}" --output "${3}" --config "${1}/config.yml"
else 
  echo "::warning ::git-chlog configuration was not found, skipping changelog generation."
fi