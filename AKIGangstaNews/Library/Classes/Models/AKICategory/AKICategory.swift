//
//  AKICategory.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 13.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKICategory: NSObject, NSCoding {
    
    var name: String?
    var selected: Bool?
    
    convenience init(name: String) {
        self.init(name: name, selected: false)
    }
    
    init(name: String, selected: Bool) {
        self.name = name
        self.selected = selected
    }
    
    public required init?(coder aDecoder: NSCoder){
        super.init()
        self.name = self.decode(decoder: aDecoder, key: kAKICategoryName)
//        self.enabled = self.decode(decoder: aDecoder, key: kAKICategoryState)
    }
    
    public func encode(with aCoder: NSCoder) {
        self.encode(encoder: aCoder, field: self.name!, key: kAKICategoryName)
//        self.encode(encoder: aCoder, field: self.enabled!, key: kAKICategoryState)
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return AKICategory(name: self.name!, selected: self.selected!)
    }
    
    //MARK: Private
    
    private func decode(decoder: NSCoder, key: String) -> String {
        return decoder.decodeObject(forKey: key) as! String
    }
    
    private func encode(encoder: NSCoder, field: String, key: String) {
        encoder.encode(field, forKey: key)
    }
    
}
