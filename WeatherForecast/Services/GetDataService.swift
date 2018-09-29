//
//  GetDataService.swift
//  WeatherForecast
//
//  Created by CinqTest on 29/09/18.
//  Copyright © 2018 CinqTest. All rights reserved.
//

import Foundation

struct GetData {
    
    struct NetworkService {
    
        static func request(getObject url: String, completion: @escaping ([String:Any]) -> Void) {
            guard let url = URL(string: url) else { return }
            let session = URLSession.shared
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request) { (data, response, error) in
                guard let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] else { return }
                completion(json!)
            }
            task.resume()
        }
    }
    
    struct LocalService {
        
        static func load(json name: String, completion: @escaping ([[String:Any]]) -> Void) {
            guard let path = Bundle.main.path(forResource: name, ofType: "json") else { return }
            do {
                let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                guard let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]] else { return }
                completion(json!)
            }
        }
    }
    
}
