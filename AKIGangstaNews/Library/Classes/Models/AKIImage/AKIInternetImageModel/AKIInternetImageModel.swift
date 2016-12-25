//
//  AKIInternetImageModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 16.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIInternetImageModel: AKILocalImageModel {
    
    var downloadTask: URLSessionDownloadTask? = nil {
        willSet (newDownloadTask) {
            self.downloadTask?.cancel()
            self.downloadTask = newDownloadTask
            self.downloadTask?.resume()
        }
    }

    var fileManager: FileManager {
        return FileManager.default
    }
    
    var documentsPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }

    var session: URLSession {
        return .shared
    }
    
    var fileName: String {
        return (self.url?.absoluteString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlUserAllowed))!
    }
    
    var filePath: String {
        return self.path.appending("/\(self.fileName)")
    }
    
    var fileURL: URL {
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
            let image = self.loadImageAtURL(URL(string: self.filePath)!)
            if image == nil {
                self.removeCorruptedImage()
            } else {
                self.finishLoadingImage(image!)
                return
            }
        }
        
        self.loadFromInternet()
    }
    
    func removeCorruptedImage() {
        do {
            try self.fileManager.removeItem(atPath: self.filePath)
        } catch {
            
        }
    }
    
    func loadFromInternet() {
        self.downloadTask = self.session.downloadTask(with: self.fileURL, completionHandler: self.completionHandler())
    }
    
    func completionHandler() -> (URL?, URLResponse?, Error?) -> Swift.Void {
        return { (location, response, error) in
            do {
                if error == nil {
                    try self.fileManager.copyItem(atPath: (location?.path)!, toPath: self.filePath)
                    self.finishLoadingImage(self.loadImageAtURL(URL(string: self.filePath)!)!)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
