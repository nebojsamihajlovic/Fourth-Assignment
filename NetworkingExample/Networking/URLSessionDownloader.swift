//
//  URLSessionDownloader.swift
//  NetworkingExample
//
//  Created by Rasko Gojkovic on 3/3/17.
//  Copyright © 2017 Plantronics. All rights reserved.
//

import Foundation

class URLSessionDownloader: Downloader {
    func getResponse(urlString: String, onResponse callback : @escaping (Data?, Error?) -> () ) {
        
        let config = URLSessionConfiguration.default;
        let session = URLSession(configuration: config)
        
        
        guard let url = URL(string: urlString) else {
            let err = DownloaderError.URLError("Can't create URL from given string")
            callback(nil, err)
            return
        }
        
        let task = session.dataTask(with: url) { (data, resp, error) in
            
            if let error = error {
                let err = DownloaderError.TransferError(error)
                callback(nil, err)
                return
            }
            
            
            if let data = data{
                callback(data, nil)
            } else {
                let err = DownloaderError.DataError("No data!")
                callback(nil, err)
            }
        }
        
        task.resume()
        
    }
    

    func downloadImage(urlString: String, onDownload callback : @escaping (Data?, Error?) -> ()){
        let config = URLSessionConfiguration.default;
        let session = URLSession(configuration: config)
        
        
        guard let url = URL(string: urlString) else {
            let err = DownloaderError.URLError("Can't create URL from given string")
            callback(nil, err)
            return
        }
        
        let task = session.downloadTask(with: url) { (url, resp, error) in
            if let error = error {
                let err = DownloaderError.TransferError(error)
                callback(nil, err)
                return
            }
            
            
            if let url = url{
                do{
                    let data = try Data(contentsOf: url)
                    callback(data, nil)
                    
                } catch let error {
                    callback(nil, error)
                }
            } else {
                callback(nil, DownloaderError.DataError("Bad data"))
            }
        }
        
        task.resume()
    }
}
