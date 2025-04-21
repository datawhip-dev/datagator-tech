#!/usr/bin/env bash
# check_missing_tests.sh
# Validates that each shell or AWK module has a corresponding test script.

# bash configuration:
# 1) Exit script if you try to use an uninitialized variable.
set -o nounset

# 2) Exit script if a statement returns a non-true return value.
set -o errexit

# 3) Use the error status of the first failure, rather than that of the last item in a pipeline.
set -o pipefail

source "$(dirname "$0")/../lib/log_lib.sh"

function main() {
  log::init

  local -i missing_tests=0

  log_info '🔍 Scanning for shell modules without tests...'
  _check_shell_tests || true

  log_info '🔍 Scanning for AWK modules without tests...'
  _check_awk_tests || true

  if [[ ${missing_tests} -gt 0 ]]; then
    log_error "❌ ${missing_tests} missing test files detected."
    exit 1
  else
    log_info '✅ All modules have corresponding *_test.sh files.'
  fi

  log::shutdown
}

function _check_shell_tests() {
  find scripts -type f -name '*.sh' ! -name '*_test.sh' ! -path '*/tests/*' | while read -r module; do
    local -r module_dir="$(dirname "${module}")"
    local -r module_name="$(basename "${module}" .sh)"
    local -r test_file="${module_dir}/tests/${module_name}_test.sh"
    if [[ ! -f "${test_file}" ]]; then
      log_warn "⚠️  Missing test for shell module: ${module} → expected ${test_file}"
      missing_tests=$((missing_tests + 1))
    fi
  done
}

function _check_awk_tests() {
  find scripts -type f -name '*.awk' ! -path '*/tests/*' | while read -r awkfile; do
    local -r dir="$(dirname "${awkfile}")"
    local -r name="$(basename "${awkfile}" .awk)"
    local -r test_file="${dir}/tests/${name}_awk_test.sh"
    if [[ ! -f "${test_file}" ]]; then
      log_warn "⚠️  Missing test for AWK module: ${awkfile} → expected ${test_file}"
      missing_tests=$((missing_tests + 1))
    fi
  done
}

main "$@"
