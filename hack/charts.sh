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

PORTEFAIX_URL="https://github.com/portefaix/portefaix.git"
PORTEFAIX_VERSION="v0.20.0"
PROJECT="portefaix"

NO_COLOR="\033[0m"
DEBUG_COLOR="\e[34m"
INFO_COLOR="\e[32m"
ERROR_COLOR="\e[31m"
WARN_COLOR="\e[35m"

STARTFLAG="<!-- BEGIN_PORTEFAIX_DOC -->"
ENDFLAG="<!-- END_PORTEFAIX_DOC -->"

COMPONENT_DOC_DIR="content/en/docs/components"


function init_repository() {
    echo -e "${INFO_COLOR}Clone repository: ${PORTEFAIX_URL}${NO_COLOR}"
    git clone ${PORTEFAIX_URL}
    pushd ${PROJECT}
    git checkout ${PORTEFAIX_VERSION}
    popd
}


function component_documentation() {
    local manifest=$1
    local component=$2
    local doc=$3

    if ! grep -q "HelmRelease" "${manifest}" ; then
        echo -e "No HelmRelease file: ${manifest}"
        return
    fi

    if [ ! -f "${doc}" ]; then
        echo -e "${WARN_COLOR}No documentation file: ${doc}${NO_COLOR}"
        return
    fi

    local chart_repo_url=$(grep registryUrl "${manifest}" | awk -F"=" '{ print $2 }')
    local chart_repo_name=$(yq e '.spec.chart.spec.sourceRef.name' "${manifest}")
    local chart_name=$(yq e '.spec.chart.spec.chart' "${manifest}")
    local chart_version=$(yq e '.spec.chart.spec.version' "${manifest}")
    local chart_namespace=$(yq e '.spec.targetNamespace' "${manifest}")

    local tmpfile=$(mktemp)
    local START=false

    echo -e "${DEBUG_COLOR}Documentation into: ${doc}${NO_COLOR}"

    while read LINE; do
        # echo "${LINE}"
        if [ "${START}" == "true" ]; then
            echo "" >> ${tmpfile}
            echo "* Repository URL: ${chart_repo_url}" >> ${tmpfile}
            echo "* Repository: \`${chart_repo_name}\`" >> ${tmpfile}
            echo "* Chart: \`${chart_name}\`" >> ${tmpfile}
            echo "* Version: \`${chart_version}\`" >> ${tmpfile}
            echo "* Namespace: \`${chart_namespace}\`" >> ${tmpfile}
            echo "" >> ${tmpfile}
            break
        elif [ "${LINE}" == "${STARTFLAG}" ]; then
                START="true"
                echo "${STARTFLAG}" >> ${tmpfile}
                continue
        else
            echo "${LINE}" >> ${tmpfile}
        fi
    done < ${doc}

    echo "${ENDFLAG}" >> ${tmpfile}
    # cat ${tmpfile}
    mv ${tmpfile} ${doc}
}


function update_components() {
    manifest_dir=$1
    namespace=$2
    component=$3
    doc_dir=$4

    # echo "${manifest_dir} ##### ${component} ###"
    for manifest in $(find "${manifest_dir}/${namespace}/${component}" -name '*.yaml'); do
        filename=$(basename ${manifest})
        if [ "${filename}" != "kustomization.yaml" ]; then
            echo -e "- ${filename}"
            # case ${component} in
            #     kube-prometheus-stack)
            #         component_documentation "${manifest}" "${component}" "content/en/docs/components/${namespace}/alertmanager.md"
            #         component_documentation "${manifest}" "${component}" "content/en/docs/components/${namespace}/kube-state-metrics.md"
            #         component_documentation "${manifest}" "${component}" "content/en/docs/components/${namespace}/node-exporter.md"
            #         component_documentation "${manifest}" "${component}" "content/en/docs/components/${namespace}/prometheus.md"
            #         component_documentation "${manifest}" "${component}" "content/en/docs/components/${namespace}/prometheus-operator.md"
            #         ;;
            #     *)
            #         component_documentation "${manifest}" "${component}" "content/en/docs/components/${namespace}/${component}.md"
            #         ;;
            # esac
            component_documentation "${manifest}" "${component}" "content/en/docs/components/${namespace}/${component}.md"
        fi
    done
}


function manage_components() {
    directory=$1

    local manifests_dir="${directory}/kubernetes/base"
    for namespace in $(ls "${manifests_dir}"); do
        if [ "${namespace}" != "crds" ]; then
            echo -e "${INFO_COLOR}-> ${namespace}${NO_COLOR}"
            for component in $(ls "${manifests_dir}/${namespace}"); do
                if [ "${component}" != "namespace" ]; then
                    echo -e "${INFO_COLOR}==> ${component}${NO_COLOR}"
                    update_components "${manifests_dir}" "${namespace}" "${component}" "${COMPONENT_DOC_DIR}"
                fi
            done
        fi
    done
}

tmpdir=$(mktemp -d)
pushd ${tmpdir}
init_repository
popd
manage_components "${tmpdir}/${PROJECT}"
rm -fr ${tmpdir}
