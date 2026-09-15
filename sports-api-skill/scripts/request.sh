#!/usr/bin/env bash

set -euo pipefail

usage() {
  printf 'Usage: %s /api/path key=value [key=value ...]\n' "${0##*/}" >&2
}

if (( $# < 1 )); then
  usage
  exit 64
fi

endpoint=$1
shift

case "$endpoint" in
  /api/*) ;;
  *)
    printf 'Error: endpoint must begin with /api/.\n' >&2
    exit 64
    ;;
esac

: "${SPORTS_API_APP_ID:?SPORTS_API_APP_ID is not configured}"
: "${SPORTS_API_APP_SECRET:?SPORTS_API_APP_SECRET is not configured}"

base_url=${SPORTS_API_BASE_URL:-https://apic.17honghuoyun.com}
base_url=${base_url%/}

case "$base_url" in
  https://*) ;;
  http://localhost*|http://127.0.0.1*) ;;
  *)
    printf 'Error: SPORTS_API_BASE_URL must use HTTPS (HTTP is allowed only for localhost).\n' >&2
    exit 64
    ;;
esac

case "${SPORTS_API_APP_ID}${SPORTS_API_APP_SECRET}" in
  *$'\n'*|*$'\r'*)
    printf 'Error: credential values must not contain line breaks.\n' >&2
    exit 64
    ;;
esac

escape_curl_config_value() {
  local value=$1
  value=${value//\\/\\\\}
  value=${value//\"/\\\"}
  printf '%s' "$value"
}

app_id_config=$(escape_curl_config_value "$SPORTS_API_APP_ID")
app_secret_config=$(escape_curl_config_value "$SPORTS_API_APP_SECRET")

curl_args=(
  --fail-with-body
  --silent
  --show-error
  --request POST
  "${base_url}${endpoint}"
)

for field in "$@"; do
  case "$field" in
    *=*) curl_args+=(--form-string "$field") ;;
    *)
      printf 'Error: form field must use key=value syntax: %s\n' "$field" >&2
      exit 64
      ;;
  esac
done

{
  printf 'header = "app-id: %s"\n' "$app_id_config"
  printf 'header = "app-secret: %s"\n' "$app_secret_config"
} | curl --config - "${curl_args[@]}"
