//
//  WeatherData.swift
//  NetworkingExample
//
//  Created by Rasko Gojkovic on 3/2/17.
//  Copyright © 2017 Plantronics. All rights reserved.
//

import Foundation

class WeatherConstants{
    
    static func UrlForIcon(icon: String) -> (String){
        return iconUrlBase + icon + ".png"
    }
    static let APIKey = "c675d1d58a86458b56433907f81b1b76"
    static let iconUrlBase = "http://openweathermap.org/img/w/"
}
