//
//  AKICategoryModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 09.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

public enum Category: String {
    case World = "World"
    case Politics = "Politics"
    case Sport = "Sport"
    case Business = "Business"
    case Tech = "Tech"
    case Science = "Science"
    case Arts = "Arts"
    case Travel = "Travel"
}

let kAKIFileName: String = "AKICategoryModel.plist"

class AKICategoryModel: AKIArrayModel {
    
    var fileManager: FileManager {
        return FileManager.default
    }
    
    var documentsPath: String {
        return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)]
    }
    
    var path: String {
        return self.documentsPath + NSTemporaryDirectory().appendingPathComponent(kAKIFileName)
    }
    
    var cached: BOOL {
        return self.fileManager.fileExists(atPath: self.path)
    }
    
    //MARK: Initializations and Deallocations
    
    override init() {
        self.fillCategories()
    }
    
    override init(_ categories: AKIArrayModel) {
        self.objects = categories
    }
    
    deinit {
        self.categories = nil
    }
    
    //MARK: Public
    
    override func performLoading() {
        var model = nil
        
        if self.cached != nil {
            model = self.fillDefaulCategories()
        } else {
            model = NSKeyedUnarchiver.unarchiveObject(withFile: self.path)
        }
        
        self.addObjects(model)
    }
    
    public func save() {
        self.fileManager.createFile(atPath: self.path, contents: nil, attributes: nil)
        NSKeyedArchiver.archiveRootObject(self.categories, toFile: self.path)
    }
    
    //MARK: Private
    
    private func fillCategories() {
        if self.cached {
            self.load()
        } else {
            self.addObjects([Category.World,
                             Category.Politics,
                             Category.Sport,
                             Category.Business,
                             Category.Tech,
                             Category.Science,
                             Category.Arts,
                             Category.Travel])
        }
    }
}
