# usb-canary
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)

A Linux or OSX shell script to monitor usb devices while your computer is locked. Get notified when someone plugs in or removes a usb device

`./usb_canary`

Logging all events
`PARANOID=1 ./usb_canary`

With SMS alerting:
`TWILIO=1 TWILIO_FROM="+16665554321" TWILIO_TO="+1123456789" TWILIO_SID="oaiufs0al444236675kjfh" TWILIO_AUTH="8489287927FGKDGKGD" ./usb_canary`

With Slack alerting:
`SLACK=1 SLACK_URL="https://hooks.slack.com/services/XX/XXXX/XXXX" ./usb_canary`
or with full slack config:
`SLACK_URL="https://hooks.slack.com/services/XX/XXXX/XXXX" SLACK_BOT="MyBot" SLACK_SUBJECT="Report Usb Canary" SLACK_COLOR="danger" ./usb_canary`

Just with notify-send alerting (just to test and only with graphical desktop):
`NOTIF=1 NOTIF_BIN="/usr/bin/notify-send" ./usb_canary`

If you should set environment's variables in file, you could it in .env file
Copy .env.sample to .env and update values with yours:
```
PARANOID=1

TWILIO=0
TWILIO_FROM="+1123456789"
TWILIO_TO="+1123456789"
TWILIO_SID="oaiufs0al444236675kjfh"
TWILIO_AUTH="8489287927FGKDGKGD"
TWILIO_URL="https://api.twilio.com/2010-04-01/Accounts/$TWILIO_SID/Messages"

SLACK=0
SLACK_URL="https://hooks.slack.com/services/XX/XXXX/XXXX"
SLACK_BOT="UsbCanaryBot"
SLACK_SUBJECT="Report Usb Canary"
SLACK_COLOR="danger"

NOTIF=1
NOTIF_BIN="/path/to/notify-send"
NOTIF_LEVEL="normal|critical"
```

Set TWILIO, SLACK and NOTIF to 1 to enable it, set to 0 to disable

## Authors

fijimunkii

## License

This project is licensed under the GNU GPLv3 License - see the [LICENSE](LICENSE.txt) file for details.
