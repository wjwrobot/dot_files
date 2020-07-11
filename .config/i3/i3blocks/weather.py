#!/usr/bin/python3

import json
import urllib
import urllib.parse
import urllib.request

def main():
    city = "Xiamen, China"
    api_key = "f958ec1f8a73e7421886eb650549af24"
    url = "http://api.openweathermap.org/data/2.5/weather?"
    try:
        data = urllib.parse.urlencode({'q': city, 'appid': api_key, 'units': 'metric'})
        weather = json.loads(urllib.request.urlopen(url + data).read())

        desc = weather['weather'][0]['description'].capitalize()
        icons = {"Thunderstorm":"", "Drizzle":"", "Rain":"", "Snow":"", "Mist":"", "Smoke":"", "Haze":"", "Dust":"", "Fog":"", "Sand":"", "Dust":"", "Ash":"", "Squall":"", "Tornado":"", "Clear":"", "Clouds":"", "Broken clouds":""}
        icon = icons.get (desc, '')
        if (icon):
            icon += " "
        temp = int(float(weather['main']['temp']))
        #print('{}{} {}°C'.format(icon, desc, temp))
        print('{}{}°C\n'.format(icon, temp))
    except:
        exit

if __name__ == "__main__":
    main()
