#!/usr/bin/env bash
# strip_pua_awk_test.sh
# Tests for AWK module strip_pua.awk

# bash configuration:
set -o nounset
set -o errexit
set -o pipefail

source "$(dirname "$0")/../../log_lib.sh"

function main() {
  log::init

  local -r AWK_SCRIPT="$(dirname "$0")/../strip_pua.awk"

  _test_case "abc" "abc"
  _test_case $'abcâxyz' "abc​xyz"
  _test_case $'abcîxyz' "abcxyz"
  _test_case $'abcó xyz' "abcxyz"

  log_info "✅ All strip_pua.awk tests passed"

  log::shutdown
}

function _test_case() {
  local -r input="$1"
  local -r expected="$2"
  local result
  result=$(echo -ne "${input}" | hexdump -v -e '/1 "%02X "' | awk -f "${AWK_SCRIPT}")

  if [[ "${result}" != "${expected}" ]]; then
    log_error "❌ FAIL: input='${input}' expected='${expected}' got='${result}'"
    return 1
  else
    log_info "✅ PASS: input='${input}'"
  fi
}

main "$@"
