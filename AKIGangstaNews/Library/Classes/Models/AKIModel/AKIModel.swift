//
//  AKIModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 09.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIModel {
    
    func load() {
        self.synced(lock: self) {
            DispatchQueue.global().async {
                self.performLoading()
            }
        }
    }
    
    func performLoading() {
        
    }
        
    func synced(lock: AnyObject, closure: () -> ()) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
}
