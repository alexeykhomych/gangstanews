//
//  AKIContent.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 01.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIContent: NSObject {
    public var dataText: NSString!
    public var imageModel: UIImageView!
    
    init(dataText: String, imageModel: UIImageView) {
        self.dataText = dataText as NSString!
        self.imageModel = imageModel
    }
    
}
