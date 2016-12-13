//
//  AKIModelCache.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 11.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

final class AKIModelCache {
    
    static let shared = AKIModelCache()
    
    private var mapTable: NSMapTable<AnyObject, AnyObject>?
    
    //MARK: Initializations and Deallocations
    
    init() {
        self.mapTable = NSMapTable.strongToWeakObjects()
    }
    
    deinit {
        self.mapTable = nil
    }
    
    //MARK: Public
    
    func objectForKey(_ key: URL) -> AnyObject {
        return (self.mapTable?.object(forKey: key as AnyObject?))!
    }
    
    func addObject(_ object: AKIContent) {
        self.mapTable?.setObject(object, forKey: object.imageURL as AnyObject?)
    }
    
    
    func removeObject(_ object: AKIContent) {
        self.mapTable?.removeObject(forKey: object.imageURL as AnyObject?)
    }
}
