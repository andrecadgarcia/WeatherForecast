//
//  ViewController.swift
//  WeatherForecast
//
//  Created by CinqTest on 29/09/18.
//  Copyright © 2018 CinqTest. All rights reserved.
//

import UIKit

class SelectCityViewController: UIViewController {

    @IBOutlet weak var selectCityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var citiesTableView: UITableView!
    
    var cities = [City]()
    var filteredCities = [City]()
    var selectedCity: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.citiesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CityCell")
        
        self.loadCities()
    }
    
    func loadCities() {
        let _ = GetCities(completion: { (array) in
            for item in array {
                self.cities.append(City(id: item.id, name: item.name))
            }
            self.filterCities(nameTyped: self.cityTextField.text)
        })
    }
    
    func filterCities(nameTyped: String?) {
        if (nameTyped != nil && nameTyped!.count > 0) {
            self.filteredCities = self.cities.filter { (city) -> Bool in city.name.uppercased().hasPrefix(nameTyped!.uppercased()) }
        }
        else {
            self.filteredCities = self.cities
        }
        self.filteredCities.sort { (city1, city2) -> Bool in return city1.name < city2.name }
        DispatchQueue.main.async {
            self.citiesTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ShowForecastViewController {
            dest.city = self.selectedCity
        }
    }
}

//MARK: UITextField Function
extension SelectCityViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var textToFilter = ""
        if let text = textField.text {
            if (string == "") {
                //Handle deletion of one or many characters
                let minIndex = text.index(text.startIndex, offsetBy: 0)
                let maxIndex = text.index(text.startIndex, offsetBy: text.count - range.length)
                textToFilter = String(text[minIndex ..< maxIndex])
            }
            else {
                textToFilter = "\(text)\(string)"
            }
        }
        self.filterCities(nameTyped: textToFilter)
        return true
    }
}

//MARK: UITableView Functions
extension SelectCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = citiesTableView.dequeueReusableCell(withIdentifier: "CityCell") else { return UITableViewCell() }
        let city = self.filteredCities[indexPath.section]
        cell.textLabel?.text = city.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = self.filteredCities[indexPath.section]
        self.selectedCity = city
        self.performSegue(withIdentifier: "SelectCity", sender: nil)
    }
    
}

