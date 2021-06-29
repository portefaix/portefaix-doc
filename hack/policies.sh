#!/usr/bin/env bash

# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PORTEFAIX_URL="https://github.com/portefaix/portefaix-policies.git"
PORTEFAIX_VERSION="v0.7.0"
PROJECT="portefaix-policies"

NO_COLOR="\033[0m"
DEBUG_COLOR="\e[34m"
INFO_COLOR="\e[32m"
ERROR_COLOR="\e[31m"
WARN_COLOR="\e[35m"

OPA_STARTFLAG="<!-- BEGIN_PORTEFAIX_OPA_DOC -->"
OPA_ENDFLAG="<!-- END_PORTEFAIX_OPA_DOC -->"

KYVERNO_STARTFLAG="<!-- BEGIN_PORTEFAIX_KYVERNO_DOC -->"
KYVERNO_ENDFLAG="<!-- END_PORTEFAIX_KYVERNO_DOC -->"

POLICY_DOC="content/en/docs/development/policies.md"


function init_repository() {
    echo -e "${INFO_COLOR}Clone repository: ${PORTEFAIX_URL}${NO_COLOR}"
    git clone ${PORTEFAIX_URL}
    pushd ${PROJECT}
    git checkout ${PORTEFAIX_VERSION}
    popd
}

function manage_policies() {
    policies_file=$1
    doc=$2
    start_tag=$3
    end_tag=$4

    policies=$(grep "## PORTEFAIX" ${policies_file} | sort | sed -e "s/## /* /" | sed -e "s/* /* \`/" | sed -e "s/: /\`: /" | sed -e "s/ - /\` - /")
    local START="false"
    local END="false"
    local tmpfile=$(mktemp)

    while read LINE; do
        #echo "======> ${LINE}"
        if [ "${START}" == "true" ]; then
            echo "" >> ${tmpfile}
            echo "${policies}" >> ${tmpfile}
            echo "" >> ${tmpfile}
            echo "${end_tag}" >> ${tmpfile}
            START="false"
            END="true"
        elif [ "${LINE}" == "${start_tag}" ]; then
            START="true"
            echo "${start_tag}" >> ${tmpfile}
            continue
        elif [ "${LINE}" == "${end_tag}" ]; then
            END="false"
        elif [ "${END}" == "false" ]; then
            echo "${LINE}" >> ${tmpfile}
        fi
    done < "${doc}"

    cat ${tmpfile}
    mv ${tmpfile} ${doc}
    # echo ${doc}
}

tmpdir=$(mktemp -d)
pushd ${tmpdir}
init_repository
popd
manage_policies "${tmpdir}/${PROJECT}/opa-policies.md" "${POLICY_DOC}" "${OPA_STARTFLAG}" "${OPA_ENDFLAG}"
manage_policies "${tmpdir}/${PROJECT}/kyverno-policies.md" "${POLICY_DOC}" "${KYVERNO_STARTFLAG}" "${KYVERNO_ENDFLAG}"
rm -fr ${tmpdir}
