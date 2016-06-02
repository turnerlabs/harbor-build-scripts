#!/bin/bash
export DEFAULT_IDB_URL='http://idb.services.dmtio.net'
export DEFAULT_CATALOGIT_URL='http://catalogit.services.dmtio.net'
export DEFAULT_REGISTRY_CATALOGIT='registry.services.dmtio.net'
export DEFAULT_REGISTRY="${DEFAULT_REGISTRY_CATALOGIT}:80"

discover() {
  local product=$1
  local env=$2
  local location=$3
  local query="NOT+offline:true"

  if [ -n "${location}" ]; then
    QUERY="location:${location}+AND+${query}"
  fi
  curl -s "${DEFAULT_IDB_URL}/instances/${product}/${env}?q=${query}" | tr ',{}' "\n" | egrep '(PORT|ipaddress)' | cut -d'"' -f4 | paste -d':' - - | sed 's/^\([^.:]*\):\(.*\)$/\2:\1/'
}

random_number() {
  local n=${1:-10}

  echo -ne "$((RANDOM % n))"
}

random_server() {
  local list=($(discover "$1" "$2" "$3"))

  if [ "${#list[@]}" = "0" ]; then
    echo -ne ''
  else
    echo -ne ${list[$(random_number ${#list[@]})]}
  fi
}
