//
//  ForecastServices.swift
//  WeatherForecast
//
//  Created by CinqTest on 29/09/18.
//  Copyright © 2018 CinqTest. All rights reserved.
//

import Foundation

struct GetForecasts {
    
    init(cityId: Int, completion: @escaping ((GetForecastsResponse?) -> Void)) {
        let url = "\(URLS.API_FORECAST)?id=\(cityId)&appId=7657bcf47dc64253b20d069b4c478b4d"
        GetData.NetworkService.request(getObject: url) { (json) in
            completion(GetForecastsResponse(json: json))
        }
    }
    
    struct GetForecastsResponse {
        
        let cod: String
        let forecast: [GetWeatherResponse]
        
        init?(json: [String:Any]) {
            guard let cod = json["cod"] as? String, let list = json["list"] as? [[String:Any]] else { return nil }
            self.cod = cod
            var forecast = [GetWeatherResponse]()
            for item in list {
                guard let weather = GetWeatherResponse(json: item) else { continue }
                forecast.append(weather)
            }
            
            self.forecast = forecast
        }
    }
    
    struct GetWeatherResponse {
        
        let description: String
        let date: String
        let temperature: Double
        let temp_min: Double
        let temp_max: Double
        let humidity: Int
        let wind_speed: Double
        let pressure:Double
        
        init?(json: [String: Any]) {
            guard let date = json["dt_txt"] as? String,
                let temperature = (json["main"] as! [String:Any])["temp"] as? Double,
                let temp_min = (json["main"] as! [String:Any])["temp_min"] as? Double,
                let temp_max = (json["main"] as! [String:Any])["temp_max"] as? Double,
                let humidity = (json["main"] as! [String:Any])["humidity"] as? Int,
                let pressure = (json["main"] as! [String:Any])["pressure"] as? Double,
                let wind_speed = (json["wind"] as! [String:Any])["speed"] as? Double,
                let description = (json["weather"] as! [[String:Any]])[0]["description"] as? String else { return nil }
            
            self.date = date
            self.temperature = temperature
            self.temp_min = temp_min
            self.temp_max = temp_max
            self.humidity = humidity
            self.wind_speed = wind_speed
            self.pressure = pressure
            self.description = description
        }
    }
}
