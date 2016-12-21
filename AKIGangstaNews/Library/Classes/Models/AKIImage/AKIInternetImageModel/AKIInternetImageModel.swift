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
    
//    var downloadTask: URLSessionDataTask? = nil {
//        willSet(newDownloadTask) {
//            self.downloadTask?.cancel()
//            self.downloadTask = newDownloadTask
//            self.downloadTask?.resume()
//        }
//    }
    
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
        return (self.url?.absoluteString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlUserAllowed))!
    }
    
    var filePath: String {
        return self.path.appending(self.fileName)
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
        let url = URL(string: "https://static01.nyt.com/images/2016/12/20/us/20assess-web3/20assess-web3-sfSpan.jpg")
        self.downloadTask = self.session.downloadTask(with: url!, completionHandler: self.completionHandler())
    }
    
    func completionHandler() -> (URL?, URLResponse?, Error?) -> Swift.Void {
        return { (location, response, error) in
            var downloadedImage: UIImage? = nil
            do {
                if error == nil {
                    try self.fileManager.copyItem(atPath: (location?.path)!, toPath: self.filePath)
                    downloadedImage = self.loadImageAtURL(URL.init(string: self.filePath)!)
                }
                
                self.finishLoadingImage(downloadedImage!)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
    }

}
