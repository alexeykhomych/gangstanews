//
//  AKISortedArrayModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 14.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKISortedArrayModel: AKIArrayModel {
    
    var sortedArrayModel: AKIArrayModel?
    
    override init() {
        super.init()
        self.sortedArrayModel = AKIArrayModel()
    }
    
    func sortArrayModel(arrayModel: AKIArrayModel, parameters: String) -> NSArray {
        let mutableObjects = NSMutableArray()
        let objects = arrayModel.objects
        
        for object in objects {
            let category = (object as! AKIContent).category
            if category?.name == parameters {
                mutableObjects.add(object)
            }
        }
        
        return mutableObjects
    }
    
}
