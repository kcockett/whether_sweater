# Whether Sweater - Solo API Project - README

## Table of Contents

1. [System dependencies](#system_dependencies)
2. [Project Description](#project-description)
3. [APIs Utilized](#apis-utilized)
4. [Usage](#usage)
5. [Setup](#setup)
6. [Testing](#testing)
7. [Database Schema](#database-schema)
8. [Endpoints](#endpoints)

## System dependencies
- Ruby 3.2.2
- Rails 7.0.8
- PostgreSQL 1.1
- Bcrypt 3.1.7
- [JSON API Serializer](https://github.com/jsonapi-serializer/jsonapi-serializer) gem to quickly serialize Ruby Objects
- [Faraday](https://github.com/lostisland/faraday) gem to interact with APIs
- [SimpleCov](https://github.com/simplecov-ruby/simplecov) gem for code coverage tracking
- [ShouldaMatchers](https://github.com/thoughtbot/shoulda-matchers) gem for testing assertions
- [VCR](https://github.com/vcr/vcr) / [Webmock](https://github.com/bblimke/webmock) to stub HTTP requests in tests to simulate API interactions

## Project Description

**Wheater Sweater** is a back-end project that leverages multiple APIs to provide:
1. Weather information for any location, including current weather, a 5-day forecast, and hourly forecast information for each day
2. User registration to obtain an API key
3. User login to look up an API key
4. Roadtrip information which provides travel time and weather forecast information for your estimated time of arrival.  This feature requires an API key
5. A list of books available for your route destination


### APIs utilized
The project draws information from the following APIs:

1. [MapQuest API](https://developer.mapquest.com/) for Geolocation and travel time calculations
2. [Weather API](https://www.weatherapi.com/) to get current and forcast weather information
3. [Open Library](https://openlibrary.org/) to retrieve books about the route destination city.

## Usage

This API was created to expose endpoints for specialized search queries.  This is primarily an exercise in learning how to consume multiple APIs, filter that data for a specific output, and expose that data via API.

## Setup
- Fork and Clone the repo
- Navigate into the repo directory `cd whether_sweater`
- Install gem packages: `bundle install`
- Setup the database: `rails db:{create,migrate,seed}`

### Testing
- After completing the above setup, run the command `bundle exec rspec`

## Database Schema
```
create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "api_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
```

## Endpoints
### 5 Day Forecast
Will return the current weather for any location, the next 4 days forecast, and hourly forecast for each day

Example:  `GET /api/v0/forecast?location=cincinatti,oh`

_Example Response:_
```
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
          "last_updated": "2023-09-27 15:15",
          "temperature": 70.0,
          "feels_like": 70.0,
          "humidity": 84,
          "uvi": 6.0,
          "visibility": 9.0,
          "condition": "Overcast",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/122.png"
        },
      "daily_weather": [
        {
          "date": "2023-09-27",
          "sunrise": "07:30 AM",
          "sunset": "07:27 PM",
          "max_temp": 75.9,
          "min_temp": 64.0,
          "condition": "Moderate rain",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/302.png",
          "hourly_weather": [
            { 
              "time": "00:00",
              "temperature": 68.4,
              "conditions": "Partly cloudy",
              "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
            },
            {
              "time": "01:00",
              "temperature": 67.5,
              "conditions": "Clear",
              "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
            },
            {
              "time": "02:00",
              "temperature": 66.7,
              "conditions": "Clear",
              "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
            }
            ...
          ]
        },
        {
          "date": "2023-09-28",
          "sunrise": "07:31 AM",
          "sunset": "07:26 PM",
          "max_temp": 73.8,
          "min_temp": 61.0,
          "condition": "Heavy rain",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/308.png",
          "hourly_weather": [
            {
              "time": "00:00",
              "temperature": 66.2,
              "conditions": "Overcast",
              "icon": "//cdn.weatherapi.com/weather/64x64/night/122.png"
            },
            ...
          ]
        },
        ...     
      ]
    }
  } 
}
```

### User Registration
Allows users to pass in an email address and password to be returned an API key for use in the Roadtrip endpoint below.

Example:  `POST /api/v0/users`
This information should be sent as a JSON Payload in the body of the request:
```
{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

_Example Response:_
```
status: 201
body:
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```

### Login
Will return the user's email and their assigned API key

Example:  `POST /api/v0/sessions`
This information should be sent as a JSON Payload in the body of the request:
```
{
  "email": "whatever@example.com",
  "password": "password"
}
```

_Example Response:_
```
status: 200
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```
### Roadtrip
Will return the travel time for a trip and the weather forcast for the estimated arrival date/time

Example:  `POST /api/v0/road_trip`
This information should be sent as a JSON Payload in the body of the request:
```
{
  "origin": "Cincinatti,OH",
  "destination": "Chicago,IL",
  "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
}
```

_Example Response:_
```
{
  "data": {
    "id": "null",
    "type": "road_trip",
    "attributes": {
      "start_city": "Cincinatti, OH",
      "end_city": "Chicago, IL",
      "travel_time": "04:40:45",
      "weather_at_eta": {
        "datetime": "2023-04-07 23:00",
        "temperature": 44.2,
        "condition": "Cloudy with a chance of meatballs"
      }
    }
  }
}
```

### Book Search
Will return a list of books for any city

Example:  `GET /api/v1/book-search?location=denver,co&quantity=5`
`location` should be in the format of city,state
`quantity` should be an integer greater than 5
_Example Response:_
```
{
  "data": {
    "id": "null",
    "type": "books",
    "attributes": {
      "destination": "denver,co",
      "forecast": {
        "summary": "Cloudy with a chance of meatballs",
        "temperature": "83 F"
      },
      "total_books_found": 172,
      "books": [
        {
          "isbn": [
            "0762507845",
            "9780762507849"
          ],
          "title": "Denver, Co"
        ,
        {
          "isbn": [
            "9780883183663",
            "0883183668"
          ],
          "title": "Photovoltaic safety, Denver, CO, 1988",
        },
        { ... same format for books 3, 4 and 5 ... }
      ]
    }
  }
}
```
