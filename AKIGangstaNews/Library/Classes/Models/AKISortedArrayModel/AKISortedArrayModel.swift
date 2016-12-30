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
        return arrayModel.objects.filter({
            ($0 as? AKIContent)?.category?.name == parameters
        }) as NSArray
    }
    
}
