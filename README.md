# Sweater-Weather Project
Sweater-Weather is a JSON API that exposes the following endpoints:

```
GET /api/v1/forecast?location=denver,co
GET /api/v1/backgrounds?location=denver,co
POST /api/v1/users
POST /api/v1/sessions
POST /api/v1/road_trip
```

It consumes Google [Geocoding API](https://developers.google.com/maps/documentation/geocoding/start), [DarkSky API](https://darksky.net/dev/docs), and [Unsplash API](https://unsplash.com/developers) to generate weather forecast data given a specified location, such as "Denver, CO". The response format is JSON API 1.0 Compliant.

# Demo
[Sweater-Weather API](https://weather-sweater.herokuapp.com/api/v1/forecast?location=denver,co)

# Get started
```
$ git clone
$ bundle install
$ rake db:{create,migrate,seed}
$ rspec
```

# Versions
- Rails 6.0.0
- Ruby 2.6.3p62
