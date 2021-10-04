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
        output="${OPTARG}"
      fi
      ;;
    t )
      tag="${OPTARG}"
      ;;
  esac
done
shift $((OPTIND -1))


if [ -f "${config}/config.yml" ] && [ -f "${config}/CHANGELOG.tpl.md" ]; then
  echo "::debug ::git-chlog: -c '${config}'"
  echo "::debug ::git-chlog: -n '${next_tag}'"
  echo "::debug ::git-chlog: -o '${output}'"
  echo "::debug ::git-chlog: -t '${tag}'"
  echo "::info ::git-chlog executing command: /usr/local/bin/git-chglog --config "${config}/config.yml" ${next_tag} ${tag}"

  changelog=$(/usr/local/bin/git-chglog --config "${config}/config.yml" ${next_tag} ${tag})

  echo "----------------------------------------------------------"
  echo "${changelog}"
  echo "----------------------------------------------------------"

  echo "::debug ::git-chlog: -o '${output}'"
  if [[ ! -z "$output" ]]; then
    echo "::debug ::git-chlog -o options is set. writing changelog to ${output}"
    echo "${changelog}" > ${output}
  fi

  echo "::set-output name=changelog::$( echo "$changelog" | jq -sRr @uri )"

else 
  echo "::warning ::git-chlog configuration was not found, skipping changelog generation."
fi
