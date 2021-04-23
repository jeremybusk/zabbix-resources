# Using Vonage/Nexmo API for voice/text functions

- Register and login to account at https://dashboard.nexmo.com/
- Put some money on your account. Usually around $10
- Get a phone number (about $1 a month). You will need this for sms texts.
- Create new application.
  - Generate public & private key
  - Enable Voice & Messages via slider and point http urls to your website or valid url
  - Get info from Application and enter in .env file

.env file example from above info
````
VONAGE_APPLICATION_ID=
VONAGE_APPLICATION_SECRET_KEY64=
VONAGE_SMS_KEY=
VONAGE_SMS_SECRET=
```

# Getting pem into base64 format which is prefered for multilined information

with bash
```
apt install cl-base64
echo "pem" | base64 -w0
```

with python
```
import base64
base64.b64encode(b'data to be encoded')
```

# Using with Zabbix
- https://www.zabbix.com/documentation/current/manual/config/notifications/media
- Add new media text and voice with correct parameters. You will need to have a param with call or text from default
