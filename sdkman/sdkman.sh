#!/bin/bash
#shellcheck disable=SC1091

if [[ -z $(type -t sdk) ]] && [[ -s "/opt/sdkman/bin/sdkman-init.sh" ]]; then
    export SDKMAN_DIR="/opt/sdkman"
    if [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]]; then
        source "${SDKMAN_DIR}/bin/sdkman-init.sh"
    fi
    if [[ -s "${SDKMAN_DIR}/candidates/springboot/current/shell-completion/bash/spring" ]]; then
        source "${SDKMAN_DIR}/candidates/springboot/current/shell-completion/bash/spring"
    fi
fi
