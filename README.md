# Luasense is a framework for your ESP8266 sensors
#### This is a work-in-progress code. Feel free to fork & PR
- [Luasense Head](https://github.com/kireevco/luasense) device - could be anything that can run nginx, Lua & [lapis](https://github.com/leafo/lapis) (For instance raspberry pi)
- [Luasense Sensor](https://github.com/kireevco/luasense-sensor) devices - ESP8266 nodes running [nodemcu](https://github.com/nodemcu/nodemcu-firmware) & sensor code

This repo contains code that runs on ESP866.
Every time you send a GET request to your sensor it will respond with a JSON object that will contain sensor values:
```javascript
{
    humidity:50,
    temperature:45,
    moisture:30
}
```

### Uploading sensor code to ESP8266
To upload your code to ESP8266 you need a USB2TTL converter (any of [those](http://www.amazon.com/s/ref=nb_sb_noss_1?url=search-alias%3Daps&field-keywords=usb2ttl&x=0&y=0) or [those](http://www.aliexpress.com/premium/usb2ttl.html?SearchText=usb2ttl)) and a [luatool](https://github.com/4refr0nt/luatool).