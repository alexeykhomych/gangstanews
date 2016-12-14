//
//  AKICategory.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 13.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

let kAKICategoryName = "kAKICategoryName"
let kAKICategoryState = "kAKICategoryState"

class AKICategory: NSObject, NSCoding {
    
    var name: String?
    var enabled: Bool?
    
    convenience init(name: String) {
        self.init(name: name, enabled: true)
    }
    
    init(name: String, enabled: Bool) {
        self.name = name
        self.enabled = enabled
    }
    
    public required init?(coder aDecoder: NSCoder){
        super.init()
        self.name = self.decode(decoder: aDecoder, key: kAKICategoryName)
//        self.enabled = self.decode(decoder: aDecoder, key: kAKICategoryState)
        print("content decoded")
    }
    
    public func encode(with aCoder: NSCoder) {
        self.encode(encoder: aCoder, field: self.name!, key: kAKICategoryName)
//        self.encode(encoder: aCoder, field: self.enabled!, key: kAKICategoryState)
        
        print("content encoded")
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        print("content copied with zone")
        return AKICategory(name: self.name!, enabled: self.enabled!)
    }
    
    //MARK: Private
    
    private func decode(decoder: NSCoder, key: String) -> String {
        return decoder.decodeObject(forKey: key) as! String
    }
    
    private func encode(encoder: NSCoder, field: String, key: String) {
        encoder.encode(field, forKey: key)
    }
    
}
