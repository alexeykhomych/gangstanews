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
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    var path: String {
        return self.documentsPath + NSTemporaryDirectory().appending(kAKIFileName)
    }
    
    var cached: Bool {
        return self.fileManager.fileExists(atPath: self.path)
    }
    
    //MARK: Initializations and Deallocations
    
    override init() {
        super.init()
        self.fillCategories()
    }
    
    init(_ categories: AKIArrayModel) {
        super.init()
        self.addObjects(categories.objects)
    }
    
    //MARK: Public
    
    override func performLoading() {
        var model: Any?
        
        if self.cached {
            model = self.fillCategories()
        } else {
            model = NSKeyedUnarchiver.unarchiveObject(withFile: self.path)
        }
        
        self.addObjects(model as! NSArray)
    }
    
    public func save() {
        self.fileManager.createFile(atPath: self.path, contents: nil, attributes: nil)
        NSKeyedArchiver.archiveRootObject(self.objects, toFile: self.path)
    }
    
    //MARK: Private
    
    private func fillCategories() {
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
