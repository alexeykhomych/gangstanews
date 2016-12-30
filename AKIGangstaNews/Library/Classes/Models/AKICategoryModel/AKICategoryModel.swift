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
    
    var fileManager: FileManager {
        return FileManager.default
    }
    
    var selectedCategory: AKICategory? = nil {
        willSet (newSelectedCategory) {
            self.selectedCategory?.selected = false
            self.selectedCategory = newSelectedCategory
        }
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
    
    //MARK: Public
    
    func addObject(_ category: AKICategory) {
        self.synced(lock: self) {
            let objects = self.objects as! Array<AKICategory>
            var conteints = false
            for object in objects {
                if object.name == category.name {
                    conteints = true
                }
            }
            
            if !conteints {
                super.addObject(category)
            }
        }
    }
    
    func removeObject(_ category: AKICategory) {
        self.synced(lock: self) {
            super.removeObject(category)
        }
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
        self.synced(lock: self) {
            super.removeObjectAtIndex(index)
        }
    }
    
    func selectedCategory(newCategory: AKICategory) {
        self.synced(lock: self) {
            self.selectedCategory?.selected = false
            self.selectedCategory = newCategory
        }
    }
}
