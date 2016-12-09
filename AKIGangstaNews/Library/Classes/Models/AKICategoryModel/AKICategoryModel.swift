//
//  AKICategoryModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 09.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

public enum Category: String {
    case Politics = "Politics"
    case Sport = "Sport"
}

let kAKIFileName: String = "AKICategoryModel.plist"

class AKICategoryModel: AKIModel {
    
    var categories: AKIArrayModel? = nil
    
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
        self.categories = AKIArrayModel()
        self.fillDefaulCategories()
    }
    
    override init(_ categories: AKIArrayModel) {
        self.categories = categories
    }
    
    deinit {
        self.categories = nil
    }
    
    //MARK: Public
    
    override func performLoading() {
        var model = nil
        
        if self.cached != nil {
            model = AKIUser()
        } else {
            self.categories?.addObjects(model)
        }
    }
    
    public func save() {
        self.fileManager.createFile(atPath: self.path, contents: nil, attributes: nil)
        NSKeyedArchiver.archiveRootObject(self.categories, toFile: self.path)
    }
    
    //MARK: Private
    
    private func fillDefaulCategories() {
        self.categories?.addObjects([Category.Politics, Category.Politics])
    }
}
