//
//  AKIModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 09.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIModel {
    
    public func load() {
        DispatchQueue.global().async {
            self.performLoading()
        }
    }
    
    func performLoading() {
        
    }

}
