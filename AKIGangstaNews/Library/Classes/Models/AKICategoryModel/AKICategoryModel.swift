//
//  AKICategoryModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 09.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

let kAKICategoryWorld = "World"
let kAKICategoryPolitics = "Politics"
let kAKICategorySport = "Sport"
let kAKICategoryBusiness = "Business"
let kAKICategoryTech = "Tech"
let kAKICategoryScience = "Science"
let kAKICategoryArts = "Arts"
let kAKICategoryTravel = "Travel"

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
    
    override func addObject(_ object: Any) {
        super.addObject(object)
        self.save()
    }
    
    override func removeObject(_ object: Any) {
        super.removeObject(object)
        self.save()
    }
    
    override func removeObjectAtIndex(_ index: Int) {
        super.removeObjectAtIndex(index)
        self.save()
    }
    
    override func performLoading() {
        var model: Any?
        
        if self.cached {
            model = NSKeyedUnarchiver.unarchiveObject(withFile: self.path)
        } else {
            model = self.fillCategories()
        }
        
        self.addObjects(model as! NSArray)
        print("performLoading CategoryModel")
    }
    
    public func save() {
        self.fileManager.createFile(atPath: self.path, contents: nil, attributes: nil)
        NSKeyedArchiver.archiveRootObject(self.objects, toFile: self.path)
        print("save CategoryModel")
    }
    
    //MARK: Private
    
    private func fillCategories() {
        if self.cached {
            self.load()
        }
    }
}
