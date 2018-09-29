//
//  Weather.swift
//  WeatherForecast
//
//  Created by CinqTest on 29/09/18.
//  Copyright © 2018 CinqTest. All rights reserved.
//

import Foundation

class Weather {
    
    let description: String
    let date: Date?
    let temperature: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
    let wind_speed: Double
    let pressure:Double
    
    init(description: String, date: String, temperature: Double, temp_min: Double, temp_max: Double, humidity: Int, wind_speed: Double, pressure:Double) {
        self.description = description
        self.date = DateUtil.stringToDate(string: date)
        self.temperature = temperature
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.humidity = humidity
        self.wind_speed = wind_speed
        self.pressure = pressure
    }
    
    init?(json: [String:Any]) {
        guard let description = json["description"] as? String,
            let date = json["date"] as? String,
            let temperature = json["temperature"] as? Double,
            let temp_min = json["temp_min"] as? Double,
            let temp_max = json["temp_max"] as? Double,
            let humidity = json["humidity"] as? Int,
            let wind_speed = json["wind_speed"] as? Double,
            let pressure = json["pressure"] as? Double else { return nil }
        self.description = description
        self.date = DateUtil.stringToDate(string: date)
        self.temperature = temperature
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.humidity = humidity
        self.wind_speed = wind_speed
        self.pressure = pressure
    }
    
    
}
