#!/usr/bin/python

import json
import urllib
import urllib.parse
import urllib.request


def main():
    city = "Zhangzhou, China"
    api_key = "f958ec1f8a73e7421886eb650549af24"
    url = "http://api.openweathermap.org/data/2.5/weather?"
    try:
        data = urllib.parse.urlencode({'q': city, 'appid': api_key, 'units': 'metric'})
        weather = json.loads(urllib.request.urlopen(url + data).read())

        desc = weather['weather'][0]['description'].capitalize()
        icons = {"Thunderstorm":"", "Drizzle":"", "Rain":"", "Snow":"", "Mist":"", "Smoke":"", "Haze":"", "Dust":"", "Fog":"", "Sand":"", "Dust":"", "Ash":"", "Squall":"", "Tornado":"", "Clear":"", "Clouds":"", "Broken clouds":""}
        icon = icons.get (desc, '')
        temp = int(float(weather['main']['temp']))
        return '{}  {} {}°C'.format(icon, desc, temp)
    except:
        return ''

if __name__ == "__main__":
    print(main())
