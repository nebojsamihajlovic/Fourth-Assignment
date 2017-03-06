//
//  ViewController.swift
//  NetworkingExample
//
//  Created by Rasko Gojkovic on 3/2/17.
//  Copyright © 2017 Plantronics. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // weatherGetter = WeatherGetter(withDownloader: AlamoFireDownloader())
        
        weatherGetter = WeatherGetter(withDownloader: URLSessionDownloader())

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var maxTempText: UITextField!
    @IBOutlet weak var currTempText: UITextField!
    @IBOutlet weak var minTempText: UITextField!

    var weatherGetter: WeatherGetter!
 
    @IBAction func onWeather(_ sender: Any) {
        if let city = cityText.text {
            weatherGetter.getWeatherForCity(city) { (wData) in
                if let wData = wData {
                    self.setupWeatherData(weatherData: wData)
                }
            };
        }
    }
    
    func setupWeatherData(weatherData : WeatherData){
        self.minTempText.text = String(weatherData.tempMinC)
        self.maxTempText.text = String(weatherData.tempMaxC)
        self.currTempText.text = String(weatherData.tempC)
        
        weatherGetter.downloadIcon(withId: weatherData.iconId) { (data) in
            if let data = data {
                let img = UIImage(data: data);
                self.iconImage.image = img;
            }
        }
    }
}
