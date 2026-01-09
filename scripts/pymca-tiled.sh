#!/bin/bash

set -euo pipefail

TILED_SITE_PROFILES="$PIXI_PROJECT_ROOT/profiles"
export TILED_SITE_PROFILES

CYAN=$(tput setaf 6)
GREEN=$(tput setaf 2)
ORANGE=$(tput setaf 1)
RESET=$(tput sgr0)

TILED_USER="$(tiled whoami --profile nsls2)"

# Prompt user to log in, if needed
if [[ "$TILED_USER" =~ 'Not authenticated' ]]; then {

    echo "${CYAN}You are not logged into Tiled.${RESET}"
    echo "${ORANGE}Enter your BNL username and password then reply to the DUO prompt.${RESET}"
    tiled login --profile nsls2
}
else {

    echo "${GREEN}You are logged into Tiled as '${TILED_USER}'.${RESET}"
}
fi

# Construct a default Tiled URL for PyMca to fallback to
TILED_DEFAULT_URL='https://tiled.nsls2.bnl.gov/api/v1/metadata'

TILED_PROFILE="${TILED_PROFILE:-nsls2}"
TILED_PROFILE_INFO="$(tiled profile show "$TILED_PROFILE")"
if [[ "$?" -eq 0 ]]; then

    # Returns 'null' if 'uri' is not defined in the profile
    TILED_DEFAULT_URL=$(yq '.uri' <<< "$TILED_PROFILE_INFO");
fi
if [[ "$TILED_DEFAULT_URL" == 'null' ]]; then

    # Construct the URL manually if 'uri' is not defined in the profile
    TILED_DEFAULT_URL="https://tiled.nsls2.bnl.gov/api/v1/metadata/${TILED_PROFILE}/raw"
fi

echo "${CYAN}Launching PyMca. This may take a few moments...${RESET}"
TILED_PROFILE="$TILED_PROFILE" TILED_DEFAULT_URL="$TILED_DEFAULT_URL" pymca "$@"
