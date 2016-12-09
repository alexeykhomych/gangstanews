//
//  AKIArrayModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 09.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIArrayModel: AKIModel {

    private var objects: NSMutableArray?
    
    var objects: NSArray {
        return self.objects as? NSArray
    }
    
    //MARK: Initializations and Deallocations
    
    override init() {
        self.objects = NSMutableArray()
    }
    
    deinit {
        self.objects = nil
    }
    
    //MARK: Public
    
    public func addObject(_ object: Any) {
        self.objects?.add(object)
    }
    
    public func removeObject(_ object: Any) {
        self.objects?.remove(object)
    }
    
    public func addObjects(_ objects: NSArray) {
        for object in objects {
            self.addObject(object)
        }
    }
    
    public func removeAllObjects() {
        for object in self.objects! {
            self.removeObject(object)
        }
    }
    
    public func objectAtIndexSubscript(_ index: Int) -> Any {
        return self.objects![index]
    }
    
    public func indexOfObject(_ object: Any) -> Int {
        return (self.objects?.index(of: object))!
    }
}
