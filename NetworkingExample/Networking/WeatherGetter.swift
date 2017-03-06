//
//  WeatherGetter.swift
//  NetworkingExample
//
//  Created by Rasko Gojkovic on 3/2/17.
//  Copyright © 2017 Plantronics. All rights reserved.
//

import Foundation



class WeatherGetter {
    
    var downloader: Downloader
    
    init(withDownloader downloader: Downloader) {
        self.downloader = downloader;
    }
    
    func getWeatherForCity(_ city: String,respondOnQueue queue: DispatchQueue = DispatchQueue.main , withCallback callback: @escaping (WeatherData?)->()){
        
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(city)" + "&appid=" + WeatherConstants.APIKey
        
        downloader.getResponse(urlString: url) { (resp, err) in
            
            if let resp = resp {
                let data = ResponseParser.parseResponse(response: resp)
                
                queue.async {
                    if let data = data {
                        callback(data)
                    } else {
                        callback(nil)
                    }
                }
            }
        }
    }
    
    func downloadIcon(withId iconId: String,respondOnQueue queue: DispatchQueue = DispatchQueue.main ,withCallback callback: @escaping (Data?)->()){
        let url = WeatherConstants.UrlForIcon(icon: iconId);
        
        downloader.downloadImage(urlString: url) { (data, error) in
            queue.async {
                callback(data)
            }
        }
    }
}
