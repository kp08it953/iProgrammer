//
//  Users.swift
//  iProgrammer
//
//  Created by krunal on 10/03/21.
//  Copyright © 2021 indianic. All rights reserved.
//


import Foundation
import SVProgressHUD

class WeatherViewModel {
    
    let rest = RestManager()
    let api_key = "094aa776d64c50d5b9e9043edd4ffd00"    //5051eefe7394f1159a49612a56792681 Krunal a/c key
    var city = "Pune"
    
    public var weatherInfo : WeatherModelSwift? = nil
    
    init() {
        
        print("init called")
        weatherInfo = nil
    }
    
    
    func getWeatherInfo(_ completion: @escaping (_ success: Bool?) -> ()) {
        
        SVProgressHUD.show()
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q="+city+"&appid="+api_key) else { return }
        
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            
            SVProgressHUD.dismiss()
            if let data = results.data {
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let weatherData = try? decoder.decode(WeatherModelSwift.self, from: data) else {
                    completion(false)
                    return
                }
                
                self.weatherInfo = weatherData
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
