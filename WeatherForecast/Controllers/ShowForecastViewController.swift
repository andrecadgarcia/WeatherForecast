//
//  ShowForecastViewController.swift
//  WeatherForecast
//
//  Created by CinqTest on 29/09/18.
//  Copyright © 2018 CinqTest. All rights reserved.
//

import UIKit

class ShowForecastViewController: UITableViewController {

    @IBOutlet var forecastTableView: UITableView!
    
    var forecast = [Weather]()
    var groupedForecast = [Weather]()
    
    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.forecastTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ForecastCell")
        
        self.getForecast()
    }
    
    func getForecast() {
        guard let city = self.city else { return }
        let _ = GetForecasts(cityId: city.id) { (json) in
            guard let object = json else { return }
            for item in object.forecast {
                self.forecast.append(Weather(description: item.description, date: item.date, temperature: item.temperature, temp_min: item.temp_min, temp_max: item.temp_max, humidity: item.humidity, wind_speed: item.wind_speed, pressure: item.pressure))
            }
            self.groupForecast()
        }
    }
    
    func groupForecast() {
        for weather in self.forecast {
            var foundWeather = false
            for uniqueDayWeather in self.groupedForecast {
                guard let date1 = weather.date, let date2 = uniqueDayWeather.date else { continue }
                if DateUtil.sameDate(date1: date1, date2: date2) {
                    foundWeather = true
                    break
                }
            }
            if !foundWeather {
                self.groupedForecast.append(weather)
            }
        }
        DispatchQueue.main.async {
            self.forecastTableView.reloadData()
        }
    }
    
}

// MARK: UITableView Functions
extension ShowForecastViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupedForecast.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = forecastTableView.dequeueReusableCell(withIdentifier: "ForecastCell") else { return UITableViewCell() }
        let weather = self.groupedForecast[indexPath.section]
        cell.textLabel?.text = weather.description
        return cell
    }
}
