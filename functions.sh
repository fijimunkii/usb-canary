#!/usr/bin/env bash

function send_slack(){
    message="$1"
    if [[ -z ${SLACK_URL+x} ]] || \
        [[ "$message" == "" ]]; then
            exit 0
    fi

    if [[ -z ${SLACK_BOT+x} ]]; then color="UsbCanaryBot";fi
    if [[ -z ${SLACK_SUBJECT+x} ]]; then color="Usb Canary";fi
    if [[ -z ${SLACK_COLOR+x} ]]; then color="danger";fi

    data="{\
        \"attachments\": [\
            {\
                \"color\": \"$SLACK_COLOR\",\
                \"author_name\": \"$SLACK_BOT\",\
                \"title\": \"$SLACK_SUBJECT\",\
                \"text\": \"$message\"\
            }\
        ]\
    }"

    curl -X POST -H 'Content-type: application/json' --silent --data "$data" "$SLACK_URL"
}

function send_twilio(){
    message="$1"
    if [[ -z ${TWILIO_FROM+x} ]] || \
        [[ -z ${TWILIO_TO+x} ]] || \
        [[ -z ${TWILIO_SID+x} ]] || \
        [[ -z ${TWILIO_AUTH+x} ]] || \
        [[ -z ${TWILIO_URL+x} ]] || \
        [[ "$message" == "" ]]; then
            exit 0
    fi
    url="$TWILIO_URL"
    curl -X POST "$url" \
        --data-urlencode "Body=$message" \
        --data-urlencode "From=$TWILIO_FROM" \
        --data-urlencode "To=$TWILIO_TO" \
        -u $TWILIO_SID:$TWILIO_AUTH
}

send_notif() {
    if [[ ! -z ${NOTIF_BIN+x} ]]; then
        if [[ -z ${NOTIF_LEVEL+x} ]]; then NOTIF_LEVEL="normal"; fi
        ${NOTIF_BIN} --urgency="$NOTIF_LEVEL" "$1"
    fi
}

function alert {
    echo "$1"
    if [[ ! -z ${TWILIO+x} ]] && [[ "$TWILIO" == "1" ]]; then send_twilio "$1"; fi
    if [[ ! -z ${SLACK+x} ]] && [[ "$SLACK" == "1" ]]; then send_slack "$1"; fi
    if [[ ! -z ${NOTIF+x} ]] && [[ "$NOTIF" == "1" ]]; then send_notif "$1"; fi
}

function exit_canary {
  alert "EXIT from USB CANARY on $HOSTNAME"
  exit
}