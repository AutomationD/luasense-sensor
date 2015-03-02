# ! Work in progress ! Feel free to fork & PR

# Luasense - framework for your sensors
Head unit - anything that runs lua & lapis (for instance raspberry pi)

Sensors - ESP8266 nodes running Nodemcu or any orher REST-compatible devices.

### This repo contains a work-in-progress copy of lua code that runs on ESP8266

Every time you send a GET request to your sensor it will respond with a JSON object that will contain sensor values:
```javascript
{
    humidity:50,
    temperature:45,
    moisture:30
}
```