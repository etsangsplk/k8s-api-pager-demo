#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_ROOT=$(dirname ${BASH_SOURCE})/..
CODEGEN_PKG=${CODEGEN_PKG:-$(cd ${SCRIPT_ROOT}; ls -d -1 ./vendor/k8s.io/code-generator 2>/dev/null || echo ../code-generator)}

# generate the code with:
# --output-base    because this script should also be able to run inside the vendor dir of
#                  k8s.io/kubernetes. The output-base is needed for the generators to output into the vendor dir
#                  instead of the $GOPATH directly. For normal projects this can be dropped.
${CODEGEN_PKG}/generate-internal-groups.sh all \
  github.com/munnerz/k8s-api-pager-demo/pkg/client \
  github.com/munnerz/k8s-api-pager-demo/pkg/apis \
  github.com/munnerz/k8s-api-pager-demo/pkg/apis \
  pager:v1alpha1,v1beta1 \
  --go-header-file ${SCRIPT_ROOT}/hack/boilerplate.go.txt \
  "$@"
