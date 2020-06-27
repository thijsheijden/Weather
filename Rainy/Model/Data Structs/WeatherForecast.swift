//
//  WeatherForecast.swift
//  Rainy
//
//  Created by Thijs van der Heijden on 25/06/2020.
//

import Foundation

// API URL:
// https://api.openweathermap.org/data/2.5/onecall?lat=33.441792&lon=-94.037689&appid=ff1d31081f1b6a75d6c1148e948752fe

// MARK: - Welcome
struct WeatherForecast: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let minutely: [Minutely]?
    let hourly: [Hourly]
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, minutely, hourly, daily
    }
}

// MARK: - Current
struct Current: Codable {
    let dt, sunrise, sunset: Int
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let clouds: Int
    let visibility: Int?
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Daily
struct Daily: Codable {
    let dt, sunrise, sunset: Int
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint, windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    let clouds: Int
    let rain: Double?
    let uvi: Double

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, clouds, rain, uvi
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: - Hourly
struct Hourly: Codable {
    let dt: Int
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint: Double
    let clouds: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case clouds
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, rain
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Minutely
struct Minutely: Codable {
    let dt, precipitation: Int
}

func iconForId(id: Int) -> String {
    switch id {
    case 200...202, 230...232:
        return "thunderrain"
    case 210...221:
        return "chancethunder"
    case 300...321:
        return "chancerain"
    case 500...531:
        return "rain"
    case 600...622:
        return "snow"
    case 700...781:
        return "fog"
    case 800:
        return "clear"
    case 801, 802:
        return "partlycloudy"
    case 803, 804:
        return "partlysunny"
    default:
        return "unknown"
    }
}

func windDegreesToCompass(degrees: Int) -> String {
    switch degrees {
    case 12...33:
        return "NNE"
    case 34...56:
        return "NE"
    case 57...78:
        return "ENE"
    case 79...101:
        return "E"
    case 102...123:
        return "ESE"
    case 124...146:
        return "SE"
    case 147...168:
        return "SSE"
    case 169...191:
        return "S"
    case 192...213:
        return "SSW"
    case 214...236:
        return "SW"
    case 237...258:
        return "WSW"
    case 259...281:
        return "W"
    case 282...303:
        return "WNW"
    case 304...326:
        return "NW"
    case 326...347:
        return "NNW"
    default:
        return "N"
    }
}
