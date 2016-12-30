//
//  AKIArrayModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 09.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIArrayModel: AKIModel {

    private var mutableObjects: NSMutableArray?
    
    var count: Int {
        return self.objects.count
    }
    
    var objects: NSArray {
        return self.mutableObjects?.copy() as! NSArray
    }
    
    //MARK: Initializations and Deallocations
    
    override init() {
        self.mutableObjects = NSMutableArray()
    }
    
    deinit {
        self.mutableObjects = nil
    }
    
    //MARK: Public
    
    public func addObject(_ object: Any) {
        self.synced(lock: self) {
            self.mutableObjects?.add(object)
        }
    }
    
    public func removeObject(_ object: Any) {
        self.synced(lock: self) {
            self.mutableObjects?.remove(object)
        }
    }
    
    public func addObjects(_ objects: NSArray) {
        for object in objects {
            self.addObject(object)
        }
    }
    
    public func removeAllObjects() {
        for object in self.mutableObjects! {
            self.removeObject(object)
        }
    }
    
    func removeObjectAtIndex(_ index: Int) {
        self.synced(lock: self) {
            self.mutableObjects?.removeObject(at: index)
        }
    }
    
    public func objectAtIndexSubscript(_ index: Int) -> Any {
        return self.mutableObjects![index]
    }
    
    public func indexOfObject(_ object: Any) -> Int {
        return (self.mutableObjects?.index(of: object))!
    }
    
}
