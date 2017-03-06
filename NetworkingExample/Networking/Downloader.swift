//
//  Downloader.swift
//  NetworkingExample
//
//  Created by Rasko Gojkovic on 3/2/17.
//  Copyright © 2017 Plantronics. All rights reserved.
//

import Foundation

enum DownloaderError : Error{
    case URLError(String)
    case DataError(String)
    case TransferError(Error)
}

protocol Downloader {
    func getResponse(urlString: String, onResponse callback : @escaping (Data?, Error?) -> ())
    func downloadImage(urlString: String, onDownload callback : @escaping (Data?, Error?) -> ())
}
