//
//  WeatherViewController.swift
//  iProgrammer
//
//  Created by krunal on 10/03/21.
//  Copyright © 2021 indianic. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var viewModel = WeatherViewModel()

    @IBOutlet weak var tblSearchResults: UITableView!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var lblWeather: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //txtCity.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        updateWeatherInfo()
        
        
    }
    
    func updateWeatherInfo() {
        
        print(viewModel.city)
        viewModel.getWeatherInfo() { success in
            
            DispatchQueue.main.async {
                if success! {
                    
                    //  print(self.viewModel.weatherInfo?.weather?.first?.weatherDescription)
                    self.lblWeather.text = (self.viewModel.weatherInfo?.name)!+"\n"+"\(self.viewModel.weatherInfo?.wind?.speed ?? 0.0) km/h"
                    
                    if (!(self.viewModel.weatherInfo?.weather?.isEmpty ?? true)) {
                        self.lblWeather.text! += "\n"+(self.viewModel.weatherInfo?.weather?.first?.weatherDescription)!
                    }
                    
                } else {
                    self.lblWeather.text = ""
                    
                    UIAlertController.showAlert(title: nil, message:"No such city found", style: .alert, cancelButton: "Ok", distrutiveButton: nil, otherButtons: nil) { (_, _) in
                        // Success
                        //self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

extension WeatherViewController: UITextFieldDelegate {
        
    /*
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("textFieldDidChange")
    }*/
    
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        viewModel.city = textField.text!
        updateWeatherInfo()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        tblSearchResults.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        tblSearchResults.isHidden = true
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK:-
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //MARK:-
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell.textLabel?.text = "Pune, 37 C"
        cell.detailTextLabel?.text = "sdfsd"
        return cell
    }

    //MARK:-
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
