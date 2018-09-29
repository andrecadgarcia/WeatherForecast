//
//  WeatherTableViewCell.swift
//  WeatherForecast
//
//  Created by CinqTest on 29/09/18.
//  Copyright © 2018 CinqTest. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet var forecast: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var wind_speed: UILabel!
    @IBOutlet var day: UILabel!
    @IBOutlet var month: UILabel!
    @IBOutlet var year: UILabel!
    
    func configure(weather: Weather) {
        if (self.forecast == nil || self.temperature == nil || self.humidity == nil || self.wind_speed == nil || self.day == nil || self.month == nil || self.year == nil ) {
            return
        }
        self.forecast.text = weather.description.capitalized
        self.temperature.text = "\(weather.temperature) K"
        self.humidity.text = "\(weather.humidity)%"
        self.day.text = "\(DateUtil.getDay(date: weather.date))"
        self.month.text = "\(DateUtil.getMonth(date: weather.date))"
        self.year.text = "\(DateUtil.getYear(date: weather.date))"
    }

}
