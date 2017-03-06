//
//  AlamoFireDownloader.swift
//  NetworkingExample
//
//  Created by Rasko Gojkovic on 3/3/17.
//  Copyright © 2017 Plantronics. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class AlamoFireDownloader: Downloader {
    
    
    func getResponse(urlString: String, onResponse callback : @escaping (Data?, Error?) -> () ) {
        
        let queue = DispatchQueue(label: "response-queue", qos: .utility, attributes: [.concurrent])
        
        Alamofire.request(urlString)
            .response(
                queue: queue,
                responseSerializer: DataRequest.jsonResponseSerializer(),
                completionHandler: { response in
                    
                    print("Parsing JSON on thread: \(Thread.current) is main thread: \(Thread.isMainThread)")
                    
                    // Validate your JSON response and convert into model objects if necessary
                    if let value = response.result.value
                    {
                        print(value)
                    }
                    
                    callback(response.data, nil)
                    
                    // You are now running on the concurrent `queue` you created earlier.
                    
                    // To update anything on the main thread, just jump back on like so.
                    DispatchQueue.main.async {
                        print("Am I back on the main thread: \(Thread.isMainThread)")
                    }
            }
        )
    }
    
    
    func downloadImage(urlString: String, onDownload callback : @escaping (Data?, Error?) -> ()) {
        
        Alamofire.request(urlString)
            .responseData { response in
                if let image = response.result.value {
                    callback(response.data, nil)
                }else{
                    // check what happned.
                }
        }
    }
}
