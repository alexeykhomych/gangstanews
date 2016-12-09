//
//  AKIModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 09.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIModel: NSObject {
    
    public func load() {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
            self.performLoading()
        }
    }
    
    func performLoading() {
        
    }

}
