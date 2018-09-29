//
//  CitiesServices.swift
//  WeatherForecast
//
//  Created by CinqTest on 29/09/18.
//  Copyright © 2018 CinqTest. All rights reserved.
//

import Foundation

struct GetCities {
    
    init(completion: @escaping (([GetCitiesResponse]) -> Void)) {
        GetData.LocalService.load(json: "city.list") { (json) in
            var array = [GetCitiesResponse]()
            for item in json {
                guard let cityResponse = GetCitiesResponse(json: item) else { continue }
                array.append(cityResponse)
            }
            completion(array)
        }
    }
    
    struct GetCitiesResponse {
        
        let id: Int
        let name: String
        
        init?(json: [String:Any]) {
            guard   let id = json["id"] as? Int,
                    let name = json["name"] as? String else { return nil }
            self.id = id
            self.name = name
        }
    }
}
