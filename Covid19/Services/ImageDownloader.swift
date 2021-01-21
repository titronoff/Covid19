//
//  Downloader.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 25.11.20.
//

import UIKit

class ImageDownloader {
    
    class func downloadImageWithURL(url:String) -> UIImage! {
        
        if let data = NSData(contentsOf: NSURL(string: url)! as URL) {
            return UIImage(data: data as Data)
        } else {
            return UIImage()
        }
    }
}
