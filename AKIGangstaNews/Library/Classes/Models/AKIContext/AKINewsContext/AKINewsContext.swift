	//
//  AKINewsContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 05.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit
    
import RxSwift
import RxCocoa

import Alamofire
    
let kAKIArchivedCategoryModel = "AKIArchivedCategoryModel"

class AKINewsContext: AKIContext {
    
    override var headers: HTTPHeaders {
        return [
            kAKIContentType: kAKIApplicationJSON,
            kAKIAuthorization: "\(AuthorizationType.Bearer) \(((self.model as? AKIUser)?.authKey)!)"
        ]
    }
    
    override var url: String {
        return "\(kAKIAPIURL)\(kAKINews)"
    }
    
    var fileManager: FileManager {
        return FileManager.default
    }
    
    var documentsPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    var filePath: String {
        return self.path.appending("/\(kAKIArchivedCategoryModel)")
    }
    
    var path: String {
        return self.documentsPath
    }
    
    var cached: Bool {
        return self.fileManager.fileExists(atPath: self.filePath)
    }
    
    override func switchResponse(_ response: Alamofire.DataResponse<Any>) {
        switch(response.result) {
        case .success(_):
            if let json = response.result.value as? NSDictionary {
                self.parseJSON(json)
                self.save()
                self.parseCompleted()
            }
            break
            
        case .failure(_):
            self.load()
            self.parseError()
            break
        }
    }
    
    override func parseJSON(_ json: NSDictionary) {
        guard let data = json.object(forKey: kAKIParserData) as? [Any] else { return }
        
        let user = self.model as? AKIUser
        let objects = NSMutableArray()
        
        for categoryDictionary in data {
            guard let dictionary = categoryDictionary as? [String : Any] else { return }
            guard let categoriesDictionary = dictionary[kAKIParserCategory] as? [String : Any] else { return }
            
            let id = dictionary[kAKIParserID] as? NSNumber
            let content = AKIContent(id: (id?.stringValue)!,
                                     header: (dictionary[kAKIParserTitle] as! String?)!,
                                     dataText: "",
                                     imageURL: URL(string: (dictionary[kAKIParserImage] as! String?)!)!,
                                     category: AKICategory(name: categoriesDictionary[kAKIParserTitle] as! String))
            
            objects.add(content)
        }
        
        user?.newsArray?.addObjects(objects)
    }
    
    func load() {
        var model: Any?
        
        if self.cached {
            model = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath)
        } else {
            self.parseError()
            return
        }
        
        let user = self.model as? AKIUser
        user?.newsArray?.addObjects((model as! NSArray?)!)
    }
    
    func save() {
        self.removeCachedModel()
        self.fileManager.createFile(atPath: self.filePath, contents: nil, attributes: nil)
        NSKeyedArchiver.archiveRootObject(self.archivingModel(), toFile: self.filePath)
    }
    
    func archivingModel() -> NSArray {
        return ((self.model as? AKIUser)!.newsArray?.objects)!
    }
    
    func removeCachedModel() {
        do {
            try self.fileManager.removeItem(atPath: self.filePath)
        } catch {
            
        }
    }
}
