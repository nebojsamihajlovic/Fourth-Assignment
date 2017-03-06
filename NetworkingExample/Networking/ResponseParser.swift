//
//  ResponseParser.swift
//  NetworkingExample
//
//  Created by Rasko Gojkovic on 3/3/17.
//  Copyright © 2017 Plantronics. All rights reserved.
//

import Foundation


struct WeatherData {
    var weatherMain: String = ""
    var weatherDesc: String = ""
    var iconId: String = ""
    var tempK: Float = 0.0
    var tempMaxK: Float = 0.0
    var tempMinK: Float = 0.0
    var tempC: Float{
        get{
            return K2C(k: tempK)
        }
    }
    var tempMaxC: Float{
        get{
            return K2C(k: tempMaxK)
        }
    }
    var tempMinC: Float{
        get{
            return K2C(k: tempMinK)
        }
    }
    
    private func K2C(k : Float)->(Float){
        return k-273.15
    }
}

class ResponseParser{
    static func parseResponse(response: Data) -> WeatherData?{
        
        do {
            let json = try JSONSerialization.jsonObject(with: response, options: []) as! [String: AnyObject]
            return createWeatherData(fromDictionary: json)
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    private static func createWeatherData(fromDictionary dictionary: [String: AnyObject]) -> WeatherData?{
        
        var weatherData = WeatherData()
        var haveSomeData = false
        
        if let weatherArray = dictionary["weather"] as? [Any], let weatherSection = weatherArray[0] as? [String: AnyObject] {
            if let wMain = weatherSection["main"] as? String{
                weatherData.weatherMain = wMain
            }
         
            if let wDesc = weatherSection["description"] as? String{
                weatherData.weatherDesc = wDesc
            }
            
            if let wIco = weatherSection["icon"] as? String{
                weatherData.iconId = wIco
            }
            
            haveSomeData = true
        }
        
        if let mainSection = dictionary["main"] as? [String:Any]{
            if let temp = mainSection["temp"] as? Float{
                weatherData.tempK = temp
            }
            
            if let temp_min = mainSection["temp_min"] as? Float{
                weatherData.tempMinK = temp_min
            }
            
            if let temp_max = mainSection["temp_max"] as? Float{
                weatherData.tempMaxK = temp_max
            }
            
            haveSomeData = true
        }
        
        if haveSomeData {
            return weatherData
        } else {
            return nil
        }
    }
}
