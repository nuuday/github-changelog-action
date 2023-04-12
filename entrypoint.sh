#!/bin/sh
cd /github/workspace/

while getopts "n:c:o:t:p:" opt; do
  case ${opt} in
    c )
      if [ -z "${OPTARG}" ]; then
        echo "::error ::git-chlog path is not set using flag '-c <configuration directory>'"
        exit 1
      fi
      config=$OPTARG
      ;;
    o )
      if [ ! -z ${OPTARG} ]; then
        output="${OPTARG}"
      fi
      ;;
    t )
      tag="${OPTARG}"
      ;;
    p )
      path="${OPTARG}"
      ;;
  esac
done
shift $((OPTIND -1))

if [[ ! -z "$path" ]]; then
    echo "::debug ::git-chlog -p options is set. change directory to ${path}"
    cd $path
fi

if [ -f "${config}/config.yml" ] && [ -f "${config}/CHANGELOG.tpl.md" ]; then
  echo "::debug ::git-chlog: -c '${config}'"
  echo "::debug ::git-chlog: -o '${output}'"
  echo "::debug ::git-chlog: -t '${tag}'"
  echo "::debug ::git-chlog: -p '${path}'"
  echo "::info ::git-chlog executing command: /usr/local/bin/git-chglog --config "${config}/config.yml" ${tag}"

  changelog=$(/usr/local/bin/git-chglog --config "${config}/config.yml" ${tag})

  echo "----------------------------------------------------------"
  echo "${changelog}"
  echo "----------------------------------------------------------"

  echo "::debug ::git-chlog: -o '${output}'"
  if [[ ! -z "$output" ]]; then
    echo "::debug ::git-chlog -o options is set. writing changelog to ${output}"
    echo "${changelog}" > ${output}
  fi

  echo "changelog=$( echo "$changelog" | jq -sRr @uri )" >> $GITHUB_OUTPUT

else
  echo "::warning ::git-chlog configuration was not found, skipping changelog generation."
fi
