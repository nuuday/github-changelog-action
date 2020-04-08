#!/bin/sh
cd /github/workspace/

while getopts "n:c:o:t:" opt; do
  case ${opt} in
    c )
      if [ -z "${OPTARG}" ]; then
        echo "::error ::git-chlog path is not set using flag '-c <configuration directory>'"
        exit 1
      fi
      config=$OPTARG
      ;;
    n )
      if [ ! -z ${OPTARG} ]; then
        next_tag="--next-tag ${OPTARG}"
      fi
      ;;
    o )
      if [ ! -z ${OPTARG} ]; then
        output="--output ${OPTARG}"
      fi
      ;;
    t )
      tag="${OPTARG}"
      ;;
  esac
done
shift $((OPTIND -1))


if [ -f "${1}/config.yml" ] && [ -f "${1}/CHANGELOG.tpl.md" ]; then
  changelog=$(/usr/local/bin/git-chglog --config "${config}/config.yml" ${output} ${next_tag} ${tag})

  if [ -z "$output" ]; then
    changelog="${changelog//'%'/'%25'}"
    changelog="${changelog//$'\n'/'%0A'}"
    changelog="${changelog//$'\r'/'%0D'}"
    echo "::set-output name=changelog::${changelog}"
  fi
else 
  echo "::warning ::git-chlog configuration was not found, skipping changelog generation."
fi