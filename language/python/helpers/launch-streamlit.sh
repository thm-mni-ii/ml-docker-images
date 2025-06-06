#!/bin/bash

PORT=8501

ARGS=("$@")
for idx in "${!ARGS[@]}"; do
    if [[ "${ARGS[$idx]}" == "--server.port" ]]; then
        if [ $((idx+1)) -lt $# ]; then
            PORT="${ARGS[$((idx+1))]}"
        fi
    elif [[ "${ARGS[$idx]}" == --server.port=* ]]; then
        PORT="${ARGS[$idx]#--server.port=}"
    fi
done

if [ -n "$JUPYTER_SERVER_URL" ]; then
    STREAMLIT_URL="${JUPYTER_SERVER_URL%/}/proxy/${PORT}"
    echo "Use this URL to access streamlit: $STREAMLIT_URL"
fi

exec streamlit "$@"
