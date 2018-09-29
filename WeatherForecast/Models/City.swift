//
//  City.swift
//  WeatherForecast
//
//  Created by CinqTest on 29/09/18.
//  Copyright © 2018 CinqTest. All rights reserved.
//

import Foundation

class City {
    
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init?(json: [String:Any]) {
        guard let id = json["id"] as? Int, let name = json["name"] as? String else { return nil }
        self.id = id
        self.name = name
    }
    
    
}
