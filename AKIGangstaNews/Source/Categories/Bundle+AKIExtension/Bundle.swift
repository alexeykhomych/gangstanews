//
//  Bundle.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 24.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

extension Bundle {
    static func objectWithClass(_ cls: AnyClass) -> AnyObject {
        return Bundle.objectWithClass(cls, owner: nil)
    }
    
    static func objectWithClass(_ cls: AnyClass, owner: AnyObject?) -> AnyObject {
        return Bundle.objectWithClass(cls, owner: owner, options: nil)
    }
    
    static func objectWithClass(_ cls: AnyClass, owner: AnyObject?, options: NSDictionary?) -> AnyObject {
        return self.main.objectWithClass(cls, owner: owner, options: options)
    }
    
    func objectWithClass(_ cls: AnyClass) -> AnyObject {
        return self.objectWithClass(cls, owner: nil)
    }
    
    func objectWithClass(_ cls: AnyClass, owner: AnyObject?) -> AnyObject {
        return self.objectWithClass(cls, owner: owner, options: nil)
    }
    
    func objectWithClass(_ cls: AnyClass, owner: AnyObject?, options: NSDictionary?) -> AnyObject {
        let obj = self.loadNibNamed(String(describing: cls.self), owner: owner, options: options as! [AnyHashable : Any]?)
        return (obj as NSArray?)?.objectWithClass(cls) as AnyObject
    }
    
}
