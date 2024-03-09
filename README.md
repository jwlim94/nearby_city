This package helps to get nearby cities in Korea by providing town(읍면동) and city(시군구) name. You can adjust the result by providing filter parameters such as limit and distance (unit -- km).

## Features

This package to get nearby cities is great when you use this feature with get current location feature. By getting the current location you assume to have data on what town and city you are in either by (city, town) name or (lat, lng).

`getNearbyCityByName`: get nearby city by town(required) and city(optional) name.

`getNearbyCityByLatLng`: get nearby city by lat(required) and lng(required).

This is what each param stands for in Korean district:

- state: 시, 도
- city: 시, 군, 구
- town: 읍, 면, 동

## Getting started

Refer to the `Installing` tab to see how to install this package in your existing project. Once you install the package, refer the `Example` tab to see how to use this package.

## Additional information

The administrative district data we used was published on July 2023 from the Ministry of Public Administration and Security(행정안전부). We will update the package with the newest data as newer data gets published.
