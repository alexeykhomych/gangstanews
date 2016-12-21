	//
//  AKICategoryModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 09.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AKICategoryModel: AKIArrayModel {
    
    private var categoryStatusArray: Array<Any>
    
    var fileManager: FileManager {
        return FileManager.default
    }
    
    var selectedCategory: AKICategory?
    
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
        self.categoryStatusArray = Array()
        super.init()        
        self.fillCategories()
    }
    
    //MARK: Public
    
    func addObject(_ category: AKICategory) {
        let objects = self.objects as! Array<AKICategory>
        var conteints = false
        for object in objects {
            if object.name == category.name {
                conteints = true
            }
        }
        
        if !conteints {
            super.addObject(category)
            self.save()
        }
    }
    
    func removeObject(_ category: AKICategory) {
        super.removeObject(category)
        self.save()
    }
    
    func enabledCategories() -> AKICategory? {
        let objects = self.objects
        
        for object in objects {
            if ((object as? AKICategory)?.selected!)! {
                return object as? AKICategory
            }
        }
        
        return nil
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
    }
    
    public func save() {
        self.fileManager.createFile(atPath: self.path, contents: nil, attributes: nil)
        NSKeyedArchiver.archiveRootObject(self.objects, toFile: self.path)
    }
    
    public func observer() -> Observable<AKICategory> {
        return Observable.create { observer in

            
            return Disposables.create()
        }
    }
    
    func selectedCategory(newCategory: AKICategory) {
        self.selectedCategory?.selected = false
        self.selectedCategory = newCategory
    }
    
    //MARK: Private
    
    private func fillCategories() {
        if self.cached {
            self.load()
        }
    }
}
