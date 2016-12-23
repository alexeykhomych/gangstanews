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
    
    private var mapTable: NSMapTable<AnyObject, AKIImageModel>?
    
    //MARK: Initializations and Deallocations
    
    init() {
        self.mapTable = NSMapTable.strongToWeakObjects()
    }
    
    deinit {
        self.mapTable = nil
    }
    
    //MARK: Public
    
    func objectForKey(_ key: AnyObject) -> AKIImageModel? {
        return self.mapTable?.object(forKey: key)
    }
    
    func addObject(_ object: AKIImageModel) {
        self.synced(lock: self) {
            self.mapTable?.setObject(object, forKey: object.url as AnyObject)
        }
    }
    
    
    func removeObject(_ object: AKIImageModel) {
        self.synced(lock: self) {
            self.mapTable?.removeObject(forKey: object.url as AnyObject?)
        }
    }
    
    func synced(lock: AnyObject, closure: () -> ()) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
}
