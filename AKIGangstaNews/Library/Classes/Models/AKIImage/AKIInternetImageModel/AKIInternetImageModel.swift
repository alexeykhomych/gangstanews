//
//  AKIInternetImageModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 16.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIInternetImageModel: AKIImageModel {
    
    var downloadTask: URLSessionDataTask {
        get {
            return self.downloadTask
        } set (newDownloadTask) {
            self.downloadTask.cancel()
            self.downloadTask = newDownloadTask
            self.downloadTask.resume()
        }
    }
    
    var fileManager: FileManager {
        return FileManager.default
    }
    
    var selectedCategory: AKICategory?
    
    var documentsPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }

    var session: URLSession {
        return .shared
    }
    
    var fileName: String {
        return (self.url?.absoluteString?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlUserAllowed))!
    }
    
    var filePath: String {
        return self.path.appending(self.fileName)
    }
    
    var fileURL: NSURL {
        return self.url!
    }
    
    var path: String {
        return self.documentsPath
    }
    
    var cached: Bool {
        return self.fileManager.fileExists(atPath: self.filePath)
    }
    
    override func performLoading() {
        if self.cached {
            let image = self.loadImageAtURL(self.fileURL)
            if image == nil {
                self.removeCorruptedImage()
            } else {
                self.finishLoadingImage(image!)
            }
        }
        
        self.loadFromInternet()
    }
    
    func removeCorruptedImage() {
        do {
            try self.fileManager.removeItem(atPath: self.filePath)
        } catch {
            print("pizdos, kartinka ne ydalilas")
        }
    }
    
    func loadFromInternet() {
//        self.downloadTask = self.session.downloadTask(with: self.url!)
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration:configuration)
        let theRequest = URLRequest(url: URL(string: "")!)
        let task = session.dataTask(with: URL(string: "")!) { (data:Data?, response:URLResponse?, error:Error?) in
            
        }
        
        let task1 = session.dataTask(with: theRequest) { (data:Data?, response:URLResponse?, error:Error?) in
            
        }
        

    }
    
//    open func downloadTask(with url: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDownloadTask
    
//    func completionHandler() -> (URL?, URLResponse?, Error?) {
//        return (url: URL?, response: URLResponse?, error: Error?) {
//            if error != nil {
//                self.fileManager.copyItem(atPath: url?.path., toPath: self.filePath) throws
//            }
//        }
//    }

}
